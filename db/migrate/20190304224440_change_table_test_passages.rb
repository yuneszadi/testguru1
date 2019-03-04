class ChangeTableTestPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :test_passages, :result, :integer, default: 0
    add_index :test_passages, :result
  end
end
