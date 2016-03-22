class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_user_session
    protect_from_forgery with: :exception
    
    private
    # разрешение использования username при авторизации
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :password, :password_confirmation, :remember_me) }
        devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
    end

    # или юзер зарегистрирован, или в данных сессии хранится хэш от времени входа (для гостя)
    def set_user_session
        if current_user
            session[:user_id] = current_user.id
            session[:guest] = nil
        elsif session[:guest].nil?
            session[:guest] = Digest::MD5.hexdigest(Time.current.to_s)
        end
    end
end
