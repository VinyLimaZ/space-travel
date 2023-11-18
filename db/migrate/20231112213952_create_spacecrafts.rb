# frozen_string_literal: true

class CreateSpacecrafts < ActiveRecord::Migration[7.1]
  def change
    create_table :spacecrafts do |t|
      t.string :name
      t.integer :velocity
      t.references :space_agency, null: false, foreign_key: true
      t.integer :fuel_in_days
      t.string :type

      t.timestamps
    end
  end
end
