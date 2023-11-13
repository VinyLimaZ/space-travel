class CreateSpaceShuttleData < ActiveRecord::Migration[7.1]
  def change
    create_table :space_shuttle_data do |t|
      t.references :space_shuttle, null: false, foreign_key: { to_table: :spacecrafts }, index: true
      t.integer :max_crew_size

      t.timestamps
    end
  end
end
