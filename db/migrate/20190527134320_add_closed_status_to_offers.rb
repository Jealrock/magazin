class AddClosedStatusToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :closed, :boolean, default: false
  end
end
