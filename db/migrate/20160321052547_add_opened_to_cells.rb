class AddOpenedToCells < ActiveRecord::Migration
    def change
        add_column :cells, :opened, :boolean, default: false
    end
end
