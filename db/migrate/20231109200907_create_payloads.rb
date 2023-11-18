# frozen_string_literal: true

class CreatePayloads < ActiveRecord::Migration[7.1]
  def change
    create_table :payloads do |t|
      t.string :name
      t.string :weight
      t.text :description
      t.integer :kind

      t.timestamps
    end
  end
end
