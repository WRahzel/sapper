class AddMinescountToGames < ActiveRecord::Migration
    def change
        add_column :games, :mines_count, :integer
    end
end
