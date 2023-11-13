class CreateUfoData < ActiveRecord::Migration[7.1]
  def change
    create_table :ufo_data do |t|
      t.integer :max_crew_size
      t.references :ufo, null: false, foreign_key: { to_table: :spacecrafts }, index: true

      t.timestamps
    end
  end
end
