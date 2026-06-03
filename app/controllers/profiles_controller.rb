class ProfilesController < ApplicationController
  def show
    @profile = current_user
  end

  def update
    @profile = current_user

    @profile.update!(user_params)

    redirect_to profile_path, status: :see_other, notice: 'アカウント情報を更新しました。'
  end

  def destroy
    current_user.destroy!

    redirect_to root_path, status: :see_other, notice: 'アカウントを削除しました。'
  end

  private

  def user_params
    params.expect(user: [
      :name,
      :avatar
    ])
  end
end
