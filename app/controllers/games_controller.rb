class GamesController < ApplicationController
    before_action :authenticate_user!, only: :profile
    before_action :update_games, except: :click

    def index
        # запуск создания данных игры с передачей ID юзера или данных сессии гостя
        @game = Game.build(current_user ? current_user.id : session[:guest])
    end

    def click
        # поиск последней игры пользователя
        @game = current_user ? Game.where(user_id: current_user.id).last : Game.where(guest: session[:guest]).last
        if @game.game_result == 'none' # если игра идет
            cell = @game.cells.find_by(name: "#{params[:name]}") # найти ячейку
            if cell.opened # если ячейка открывалась, то ничего
                render nothing: true
            else # если не открывалась
                if cell.marked # если была отмечена флагом, то убирается флаг
                    @cell_list = cell.marking(false)
                else # если не была отмечена флагом, то
                    @cell_list = params[:click] == '1' ? cell.check_cell : (@cell_list = cell.marking(true)) # если клик левой (1), то открывает ячейку, если правой (не 1) - ставит флаг
                end
                @game.update(starttime: Time.current.to_i) if @game.starttime == 0 # ставит время запуска игры после первого хода
                @game.update(game_result: 'Победа', times: (Time.current.to_i - @game.starttime)) if @game.cells.where(opened: false).count == @game.mines_count # если не открыто ячеек столько же, сколько мин, то победа
            end
        else
            render nothing: true
        end
    end

    def profile
        # сбор побед и поражений для статистики при входе в профиль
        games = Game.where(user_id: current_user.id).order(times: :asc)
        @wins = games.where(game_result: 'Победа')
        @defeat_count = games.where(game_result: 'Поражение').count
    end

    private
    def update_games
        # завершение всех активных игр
        games = current_user ? Game.where(user_id: current_user.id, game_result: 'none') : Game.where(guest: session[:guest], game_result: 'none')
        games.each { |game| game.update(game_result: 'Поражение') } if games.count > 0
    end
end
