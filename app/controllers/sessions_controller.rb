class SessionsController < ApplicationController
  def new
  end

  def create
    user_info = request.env['omniauth.auth']

    user = User.find_or_initialize_by(uid: user_info['uid'])

    user.update!(name: user_info['info']['name'])

    redirect_to root_path, status: :see_other
  end
end
