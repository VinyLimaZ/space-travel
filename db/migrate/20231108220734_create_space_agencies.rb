# frozen_string_literal: true

class CreateSpaceAgencies < ActiveRecord::Migration[7.1]
  def change
    create_table :space_agencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
