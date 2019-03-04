class CreateTestsUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :tests do |t|
      t.index %i[user_id test_id], unique: true
    end
    add_column :tests_users, :result, :integer
  end
end
