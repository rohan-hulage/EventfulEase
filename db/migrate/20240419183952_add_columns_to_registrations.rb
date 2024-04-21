class AddColumnsToRegistrations < ActiveRecord::Migration[7.1]
  def change
    add_column :registrations, :name, :string
    add_column :registrations, :email, :string
    add_column :registrations, :password_digest, :string
    add_column :registrations, :register_as, :string
  end
end
