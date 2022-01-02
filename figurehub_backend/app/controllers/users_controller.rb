class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :show]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    if current_user.kind == 0
      @users = User.all
      json_response(@users)
    else
      json_response({ message: 'showing users is  not allowed' }, :method_not_allowed)
    end
  end

  # POST /signup
  # return authenticated token upon signup
  def create
    if User.find_by_name(user_params[:name])
      json_response({ message: 'username exist' }, :bad_request)
    else
      user = User.create!(user_params)
      # check avatar content type
      if params[:avatar]
        avatar_types = params[:avatar].content_type.split('/')
        if avatar_types[0] == 'image' and avatar_types[1]
          avatar_path = Rails.configuration.x.img_path.avatar + "/#{user.id.to_s}.#{avatar_types[1]}"
          file_path = Rails.configuration.x.img_path.base + avatar_path
          File.open(file_path, "wb") do |f|
            f.write(params[:avatar].read)
          end
          user.avatar = avatar_path
          user.save
        end
      end
      auth_token = AuthenticateUser.new(user.name, user.password).call
      response = { message: Message.account_created, token: auth_token }
      json_response(response, :created)
    end
  end

  # GET /users/:name
  def show
    if @user
      user_info = {
        username: @user.name,
        nickname: @user.nickname,
        type: @user.kind,
        imgpath: @user.avatar,
      }
      json_response(user_info)
    else
      json_response({message: 'no such user'})
    end
  end

  # PUT /users/:id
  def update
    if has_permission
      @user.update(user_params)
      head :no_content
    else
      json_response({ message: 'updating is not allowed' }, :method_not_allowed)
    end
  end

  # DELETE /users/:name
  def destroy
    if User.count == 1
      json_response({ message: 'must have one user' }, :method_not_allowed)
    elsif current_user.id == @user.id
      @user.destroy
      json_response(token:'')
    elsif current_user.kind == 0
      @user.destroy
      head :no_content
    else
      json_response({ message: 'destroying is not allowed' }, :method_not_allowed)
    end
  end

  private

  def user_params
    params.permit(
      :name,
      :nickname,
      :kind,
      :password,
    )
  end

  def set_user
    @user = User.find_by(name: params[:id])
  end

  def has_permission
    current_user.kind == 0 or current_user.id == @user.id
  end
end
