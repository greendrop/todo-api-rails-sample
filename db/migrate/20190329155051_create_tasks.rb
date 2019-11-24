# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user
      t.string :title
      t.text :description
      t.boolean :done, null: false, default: false
      t.timestamps
    end
  end
end
