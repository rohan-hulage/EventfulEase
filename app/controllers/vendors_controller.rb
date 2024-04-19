class VendorsController < ApplicationController
    before_action :set_vendor, only: %i[ show edit update destroy ]

    def index
        @vendors = Vendor.all
      end

    def new
      @vendor = Vendor.new
    end
  
    def create
      @vendor = Vendor.new(vendor_params)
      if @vendor.save
        flash[:notice] = "Vendor registered successfully!"
        redirect_to root_url
      else
        render 'new'
      end
    end

    def set_vendor
        @Vendor = Vendor.find(params[:id])
      end
  
    private
  
    def vendor_params
      params.require(:vendor).permit(:name, :email, :password, :password_confirmation, :register_as)
    end
end
  