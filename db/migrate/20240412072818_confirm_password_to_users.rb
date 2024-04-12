class ConfirmPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :confirm_password, :string
  end
end
