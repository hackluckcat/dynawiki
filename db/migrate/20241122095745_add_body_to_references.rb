class AddBodyToReferences < ActiveRecord::Migration[8.0]
  def change
    add_column :references, :body, :string, null: false
  end
end
