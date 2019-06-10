class AddCityToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :city, :string
  end
end
