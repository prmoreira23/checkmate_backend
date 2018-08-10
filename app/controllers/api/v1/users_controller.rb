class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:update]
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user && @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update
    @user.update(user_params)
    if @user.save
      render json: @user, status:	:no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :job_title, :industry, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
