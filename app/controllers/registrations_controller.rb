class RegistrationsController < ApplicationController
  before_action :set_registration, only: %i[show edit update destroy]

  def index
    @registrations = Registration.all
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      if @registration.register_as == 'vendor'
        redirect_to vendor_specific_path, notice: 'Registered as vendor.'
      else
        redirect_to root_url, notice: 'Registered as user.'
      end
    else
      render :new
    end
  end

  private

  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation, :register_as)
  end

  # def redirect_based_on_registration_type
  #   case @registration.register_as
  #   when 'user'
  #     redirect_to root_url
  #   when 'vendor'
  #     redirect_to root_url
  #   else
  #     # Handle other registration types if needed
  #   end
  # end
end
