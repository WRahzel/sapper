class AddStartToGame < ActiveRecord::Migration
    def change
        add_column :games, :start, :boolean, default: false
    end
end
