class AddResultToGames < ActiveRecord::Migration
    def change
        add_column :games, :game_result, :string, default: 'none'
    end
end
