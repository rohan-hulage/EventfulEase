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

  def social_events
    @decorators = Registration.where(vendor_type: 'decorator').pluck(:name).uniq
  end

  def destination_wedding
    @decorators = Registration.where(vendor_type: 'decorator').pluck(:name).uniq
  end

  def payment
    @theme_name = params[:themeName]
    @decorator_name = params[:decoratorName]
    @price = params[:price]

    # Store the payment details in the session
    session[:payment_details] = {
      theme: @theme_name,
      decorator_name: @decorator_name,
      price: @price
    }
  end

  def make_payment
    @booking = Booking.new(
      theme: params[:theme],
      booking_by: current_account.name,
      booking_for: params[:decoratorName],
      price: params[:price].delete('$').to_i,
      email: current_account.email
    )

    respond_to do |format|
      if @booking.save
        format.html { redirect_to user_profile_path, notice: 'Booking was successfully created.' }
        format.json { render json: { booking: @booking } }
      else
        format.html { redirect_to payment_path(theme: params[:theme], decoratorName: params[:decoratorName], price: params[:price]), alert: 'Error creating booking.' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end


end
