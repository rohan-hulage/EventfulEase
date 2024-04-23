class PagesController < ApplicationController
  before_action :require_login, only: :home

  def index

  end

  def home

  end

  def user_profile
    @bookings = Booking.where(email: current_account.email)
  end

  def vendor_profile

  end

  def family_occasions
    @decorators = Registration.where(vendor_type: 'decorator').pluck(:name).uniq
  end

  def payment
    @theme_name = params[:themeName]
    @decorator_name = params[:decoratorName]
    @price = params[:price].to_i
  end

  def make_payment
    @booking = Booking.new(
      theme: params[:themeName],
      vendor_name: params[:decoratorName],
      price: params[:price],
      email: current_user.email
    )

    if @booking.save
      redirect_to user_profile_path, notice: 'Booking was successfully created.'
    else
      redirect_to payment_path(themeName: params[:themeName], decoratorName: params[:decoratorName], price: params[:price]), alert: 'Error creating booking.'
    end
  end




  end
