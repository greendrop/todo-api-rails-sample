# frozen_string_literal: true

ActiveSupport.on_load :active_record do
  module ActiveRecord
    module ConnectionAdapters
      class AbstractMysqlAdapter
        def create_table_with_innodb_row_format(table_name, options = {})
          table_options = options.merge(options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC')
          create_table_without_innodb_row_format(table_name, table_options) do |td|
            yield td if block_given?
          end
        end
        alias create_table_without_innodb_row_format create_table
        alias create_table create_table_with_innodb_row_format
      end
    end
  end
end
