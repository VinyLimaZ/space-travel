class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.text :description
      t.integer :syze_in_bytes
      t.integer :kind
      t.references :documentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
