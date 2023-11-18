# frozen_string_literal: true

class CreatePlanets < ActiveRecord::Migration[7.1]
  def change
    create_table :planets do |t|
      t.string :name
      t.integer :earth_distance

      t.timestamps
    end
  end
end
