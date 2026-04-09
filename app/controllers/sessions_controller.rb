class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: %i[create]

  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_initialize_by(uid: auth['uid'])

    user.update! name: auth.dig('info', 'name')

    reset_session
    session[:current_user_id] = user.id

    redirect_to home_path, status: :see_other, notice: 'ログインしました。'
  end

  def destroy
    session.delete :current_user_id

    @current_user = nil

    redirect_to root_path, status: :see_other, notice: 'ログアウトしました。'
  end
end
