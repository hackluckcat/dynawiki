class CreatePages < ActiveRecord::Migration[8.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :body, null: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
    add_index :pages, [:language_id, :title], unique: true
  end
end
