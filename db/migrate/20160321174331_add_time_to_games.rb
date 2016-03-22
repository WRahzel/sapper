class AddTimeToGames < ActiveRecord::Migration
    def change
        add_column :games, :times, :integer, default: 0
    end
end
