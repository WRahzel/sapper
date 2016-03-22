class AddUsersToGames < ActiveRecord::Migration
    def change
        add_column :games, :user_id, :integer, default: nil
        add_column :games, :guest, :string, default: nil
        add_index :games, :user_id
    end
end
