class PagesController < ApplicationController
  before_action :require_login, only: :home

  def index

  end

  def home

  end

  def user_profile

  end

  def vendor_profile

  end

  def family_occasions
    @decorators = Registration.where(vendor_type: 'decorator').pluck(:name).uniq
  end


  end
