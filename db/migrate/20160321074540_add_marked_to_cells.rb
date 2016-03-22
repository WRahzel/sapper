class AddMarkedToCells < ActiveRecord::Migration
    def change
        add_column :cells, :marked, :boolean, default: false
    end
end
