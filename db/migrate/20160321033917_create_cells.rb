class CreateCells < ActiveRecord::Migration
    def change
        create_table :cells do |t|
            t.string :x_param
            t.string :y_param
            t.integer :game_id
            t.boolean :has_mine, default: false
            t.timestamps null: false
        end

        add_index :cells, :game_id
    end
end
