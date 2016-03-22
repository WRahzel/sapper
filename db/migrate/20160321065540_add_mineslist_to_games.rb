class AddMineslistToGames < ActiveRecord::Migration
    def change
        add_column :games, :mines, :string, array: true, default: []
    end
end
