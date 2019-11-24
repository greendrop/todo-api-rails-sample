# frozen_string_literal: true

Table  = Struct.new(:name, :sheet_name, :comment, :columns, :indexes)
Column = Struct.new(:name, :type, :not_null, :default, :primary_key, :comment)
Index  = Struct.new(:name, :columns, :primary, :unique)

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def get_schema_info(klass, index)
  table = Table.new
  table.name = klass.table_name
  table.sheet_name =
    if klass.table_name.size <= 31
      klass.table_name
    else
      "#{klass.table_name[0..27]}#{index.to_s.rjust(3, '0')}"
    end
  table.columns = []
  table.indexes = []
  table.comment = klass.connection.retrieve_table_comment(klass.table_name) if defined? MigrationComments

  column_comments =
    if defined? MigrationComments
      klass.connection.retrieve_column_comments(klass.table_name)
    else
      {}
    end
  cols = klass.columns
  cols.each do |col|
    column = Column.new
    column.name = col.name
    column.type = col.sql_type.to_s
    column.default = klass.column_defaults[column.name] unless col.default.nil? || column.type == 'jsonb'
    column.not_null = col.null
    column.primary_key = (klass.primary_key && (klass.primary_key.is_a?(Array) ? klass.primary_key.collect(&:to_sym).include?(col.name.to_sym) : col.name.to_sym == klass.primary_key.to_sym)) # rubocop:disable  Metrics/LineLength
    column.comment = column_comments[col.name.to_sym]
    table.columns << column
  end

  indexes = klass.connection.indexes(klass.table_name)
  indexes.sort_by(&:name).each do |idx|
    index = Index.new
    index.name = idx.name
    index.columns = idx.columns.join(',')
    index.unique = idx.unique
    table.indexes << index
  end

  table
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

namespace :dbdoc do # rubocop:disable Metrics/BlockLength
  desc 'テーブル定義書を作成'
  task create_table_definition: :environment do # rubocop:disable Metrics/BlockLength
    klasses = Dir['app/models/**/*.rb']
              .reject { |f| f['concerns/'] }
              .map { |f| f.gsub(%r{^app/models/(.+?)\.rb$}, '\1') }
              .map { |m| ActiveSupport::Inflector.camelize(m) }
              .map { |k| ActiveSupport::Inflector.constantize(k) }
    klasses.delete_if do |k|
      k.name == 'ApplicationRecord' || !k.included_modules.map(&:name).include?('ActiveRecord::Core')
    end
    datum = []
    klasses.each_with_index do |k, i|
      datum << get_schema_info(k, i)
    end

    package = Axlsx::Package.new
    styles = package.workbook.styles
    title = styles.add_style(bg_color: 'c0c0c0', b: true, font_name: 'Meiryo UI')
    header = styles.add_style(bg_color: 'c0c0c0', b: true, font_name: 'Meiryo UI', font_size: 'large')
    cols = styles.add_style(font_name: 'Meiryo UI')

    sheet = package.workbook.add_worksheet(name: 'テーブル一覧')
    sheet.add_row(['テーブル一覧'], style: title)
    sheet.add_row([])
    sheet.add_row(%w[テーブル名 備考], style: header)
    datum.each do |table|
      sheet.add_row do |row|
        cell = row.add_cell(table.name, style: cols)
        sheet.add_hyperlink(location: "'#{table.sheet_name}'!A1", ref: cell, target: :sheet)
        row.add_cell(table.comment, style: cols)
      end
    end

    datum.each do |table|
      sheet = package.workbook.add_worksheet(name: table.sheet_name)
      sheet.add_row(['テーブル情報'], style: title)
      sheet.add_row([])
      sheet.add_row(%w[テーブル名 備考], style: header)
      sheet.add_row([table.name, table.comment], style: cols)
      sheet.add_row([])
      sheet.add_row(['カラム情報'], style: title)
      sheet.add_row([])
      sheet.add_row(['No', 'カラム名', 'データ型', 'Not Null', 'デフォルト値', '備考'], style: header)
      table.columns.each_with_index do |col, idx|
        sheet.add_row([idx + 1, col.name, col.type, col.not_null, col.default, col.comment], style: cols)
      end
      sheet.add_row([])
      sheet.add_row(['インデックス情報'], style: title)
      sheet.add_row([])
      sheet.add_row(%w[No インデックス名 カラム ユニーク], style: header)
      table.indexes.each_with_index do |index, idx|
        sheet.add_row([idx + 1, index.name, index.columns, index.unique], style: cols)
      end
    end

    package.serialize('docs/db/table_definition.xlsx')
  end
end
