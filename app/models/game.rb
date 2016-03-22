class Game < ActiveRecord::Base
    belongs_to :user
    has_many :cells

    validates :game_result, inclusion: { in: %w(none Победа Поражение) }

    def self.build(user_id)
        game = user_id.is_a?(String) ? create(start: false, guest: user_id) : create(start: false, user_id: user_id) # создание игры для юзера или гостя
        Cell.build(game.id) # формирование ячеек
        game.set_mines # установка мин
        game
    end

    def set_mines
        x_param, y_param, mines_list = %w(a b c d e f g h i j), %w(1 2 3 4 5 6 7 8 9 10), []
        mines_count = rand(5) + 10 # рандомный выбор кол-ва мин
        mines_count.times do |i|
            rand_cell = "#{x_param[rand(9)]}#{y_param[rand(9)]}" # выбор рандомной ячейки
            while self.cells.find_by(name: rand_cell).has_mine # если там уже есть мина, то выбрать новую ячейку
                rand_cell = "#{x_param[rand(9)]}#{y_param[rand(9)]}"
            end
            mines_list.push(rand_cell)
            self.cells.find_by(name: rand_cell).update(has_mine: true) # установка мины в ячейку
        end
        self.update(start: true, mines: mines_list, mines_count: mines_count) unless self.start
        Cell.set_around(self.id) # расчет индикатора мин вокруг
    end
end
