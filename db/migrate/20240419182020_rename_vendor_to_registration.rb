class RenameVendorToRegistration < ActiveRecord::Migration[7.1]
  def change
    def change
      rename_table :vendors, :registrations
    end
  end
end
