class AddAroundToCells < ActiveRecord::Migration
    def change
        add_column :cells, :around, :integer, default: 0
    end
end
