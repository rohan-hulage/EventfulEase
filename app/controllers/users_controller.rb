class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users or /users.json
  def create
    case user_params[:register_as]
    when 'user'
      create_user
    when 'vendor'
      create_vendor
    end
  end

  private

  def create_user
    @user = User.new(user_params.except(:register_as))
    if @user.save
      flash[:notice] = "User registered successfully!"
      redirect_to root_url

    else
      render 'new'
    end
  end

  def create_vendor
    @vendor = Vendor.new(user_params.except(:register_as))
    if @vendor.save
      flash[:notice] = "Vendor registered successfully!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :register_as)
  end
end
