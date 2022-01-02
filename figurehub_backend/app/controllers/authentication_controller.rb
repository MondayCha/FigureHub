class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:name], auth_params[:password]).call
    login_user = User.find_by(name: auth_params[:name])
    user_message = {
      nickname: login_user.nickname,
      kind: login_user.kind,
      avatar: login_user.avatar,
    }
    json_response(detail: user_message, token: auth_token)
  end

  def un_authenticate
    json_response(token:'')
  end

  private

  def auth_params
    params.permit(:name, :password)
  end
end
