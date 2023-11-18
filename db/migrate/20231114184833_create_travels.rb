# frozen_string_literal: true

class CreateTravels < ActiveRecord::Migration[7.1]
  def change
    create_table :travels do |t|
      t.date :beginning_date
      t.integer :duration
      t.references :planet, null: false, foreign_key: true
      t.references :spacecraft, null: false, foreign_key: true
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
