class AddStarttimeToGames < ActiveRecord::Migration
    def change
        add_column :games, :starttime, :integer, default: 0
    end
end
