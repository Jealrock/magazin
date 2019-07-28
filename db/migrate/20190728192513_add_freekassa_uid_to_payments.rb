class AddFreekassaUidToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :freekassa_uid, :string
  end
end
