class CreatePages < ActiveRecord::Migration[8.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false, index: { unique: true }
      t.text :body, null: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
