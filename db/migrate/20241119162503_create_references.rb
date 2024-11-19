class CreateReferences < ActiveRecord::Migration[8.0]
  def change
    create_table :references do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :base_url, null: false
      t.string :image_url, null: true
      t.references :page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
