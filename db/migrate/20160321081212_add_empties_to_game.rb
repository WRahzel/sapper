class AddEmptiesToGame < ActiveRecord::Migration
    def change
        add_column :games, :empties, :string, array: true, default: []
    end
end
