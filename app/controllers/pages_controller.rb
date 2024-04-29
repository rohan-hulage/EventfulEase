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

  # Pandit Ji
  def pandit_ji
    @top_pandits = Registration.where(vendor_type: 'pandit').left_joins(:bookings).group(:name).average(:rating).sort_by { |_, v| v }.reverse.first(3)

    if params[:search].present?
      search_query = params[:search].downcase
      @search_performed = true
      @search_results = Registration.where(vendor_type: 'pandit').select do |pandit|
        pandit.name.downcase.include?(search_query) || pandit.expertise.downcase.split(',').any? { |exp| exp.strip.downcase == search_query }
      end.map do |pandit|
        average_rating = Booking.where(booking_for: pandit.name).average(:rating) || 'Not rated'
        [pandit.name, average_rating]
      end.sort_by { |_, rating| rating == 'Not rated' ? 0 : -rating.to_f }.first(3)
    else
      @search_performed = false

      @top_pandits = Registration.where(vendor_type: 'pandit').limit(3).map do |pandit|
        average_rating = Booking.where(booking_for: pandit.name).average(:rating) || 'Not rated'
        [pandit.name, average_rating]
      end
    end

  end

  def search_pandit_ji
    @search_performed = true
    @search_results = Registration.search(params[:search])
    render :pandit_ji
  end

  def payment_pandit_ji
    @pooja_name = params[:pooja_name]
    @pandit_name = params[:pandit_name]

    session[:payment_details] = {
      pooja_name: @pooja_name,
      pandit_name: @pandit_name,
    }
  end

  def make_payment_pandit_ji
    @pooja_name = params[:pooja_name]
    @pandit_name = params[:pandit_name]
    @payment_type = params[:payment_type]

    @booking = Booking.new(
      theme: @pooja_name,
      booking_by: current_account.name,
      booking_for: @pandit_name,
      price: 500,
      email: current_account.email,
      vendor_id: current_account.id,
      pooja_name: @pooja_name
    )

    respond_to do |format|
      if @booking.save
        format.html { redirect_to user_profile_path, notice: 'Booking was successfully created.' }
        format.json { render json: { booking: @booking } }
      else
        format.html { redirect_to payment_pandit_ji_path(pooja_name: @pooja_name, pandit_name: @pandit_name), alert: 'Error creating booking.' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # Astrologer
  def available_astrologer
    @astrologers = Registration.where(vendor_type: 'astrologer').pluck(:name).uniq
  end

  def payment_astrologer
    @connect_type = params[:connect_type]
    @astrologer_name = params[:astrologer_name]

    session[:payment_details] = {
      connect_type: @connect_type,
      astrologer_name: @astrologer_name
    }
  end

  def make_payment_astrologer
    @connect_type = session[:payment_details][:connect_type]
    @astrologer_name = session[:payment_details][:astrologer_name]
    @payment_type = params[:payment_type]

    @booking = Booking.new(
      theme: @connect_type,
      booking_by: current_account.name,
      booking_for: @astrologer_name,
      price: 500,
      email: current_account.email,
      vendor_id: current_account.id
    )

    respond_to do |format|
      if @booking.save
        format.html { redirect_to user_profile_path, notice: 'Booking was successfully created.' }
        format.json { render json: { booking: @booking } }
      else
        format.html { redirect_to payment_astrologer_path(connect_type: @connect_type, astrologer_name: @astrologer_name), alert: 'Error creating booking.' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end


  # Decoration
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
