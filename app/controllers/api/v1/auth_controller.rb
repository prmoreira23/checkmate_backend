class Api::V1::AuthController < ApplicationController
  before_action :set_user, only: [:login]

  def login
    if @user && @user.authenticate(params[:password])
      render json: {token: issue_token({id: @user.id})}, status: :ok
    else
      render json: false.to_json, status: :unauthorized
    end
  end

  def get_current_user
    render json: current_user
  end

  private
  def set_user
    @user = User.find_by(email: params[:email])
  end
end
