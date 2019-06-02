class RemoveEmailFromOfferAndAddPhoneNumberToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :email

    add_column :users, :phone_number, :string
  end
end
