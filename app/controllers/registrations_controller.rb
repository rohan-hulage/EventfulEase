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
        redirect_to root_url, notice: 'Registered as vendor.'
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
     params.require(:registration).permit(:name, :email, :password, :password_confirmation, :register_as, :vendor_type, :expertise)
  end
end
