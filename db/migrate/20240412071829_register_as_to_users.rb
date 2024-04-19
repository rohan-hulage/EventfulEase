class RegisterAsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :register_as, :string
  end
