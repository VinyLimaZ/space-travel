class CreateRocketData < ActiveRecord::Migration[7.1]
  def change
    create_table :rocket_data do |t|
      t.references :rocket, null: false, foreign_key: { to_table: :spacecrafts }, index: true
      t.references :payload, null: false, foreign_key: true

      t.timestamps
    end
  end
end
