class PagesController < ApplicationController
  before_action :require_login, only: [:home, :accept_booking, :reject_booking, :update_rating]

  def index
  end

  def home
  end

  def user_profile
    @bookings = Booking.where(email: current_account.email)
  end

  def vendor_profile
    @bookings = Booking.where(vendor_id: current_account.id)
    @requests = Booking.where(booking_for: current_account.name)
    @rating = Booking.where(vendor_id: current_account.id).average(:rating)
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

  def pandit_ji

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
      email: current_account.email,
      vendor_id: current_account.id
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

  def accept_booking
    @booking = Booking.find(params[:id])

    if @booking.update(vendor_id: current_account.id)
      @request = Booking.find_by(id: @booking.id, booking_for: current_account.name)
      redirect_to vendor_profile_path, notice: 'Booking accepted successfully.'

    else
      redirect_back(fallback_location: root_path, alert: 'Error accepting booking.')
    end
  end


  def reject_booking
    @booking = Booking.find(params[:id])

    # Remove the booking from the request list
    if @booking.destroy
      redirect_back(fallback_location: root_path, notice: 'Booking rejected successfully.')
    else
      redirect_back(fallback_location: root_path, alert: 'Error rejecting booking.')
    end
  end

  def update_rating
    @booking = Booking.find(params[:booking_id])
    @booking.update(rating: params[:rating])

    respond_to do |format|
      format.html { redirect_to user_profile_path, notice: 'Rating updated successfully.' }
      format.json { render json: { booking: @booking } }
    end
  end



end
