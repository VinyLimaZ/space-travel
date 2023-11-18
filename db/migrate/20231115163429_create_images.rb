# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.integer :syze_in_bytes
      t.integer :height
      t.integer :width
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
