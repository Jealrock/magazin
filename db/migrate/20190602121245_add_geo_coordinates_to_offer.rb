class AddGeoCoordinatesToOffer < ActiveRecord::Migration[5.2]
  def change
    rename_column :offers, :location, :address
    add_column :offers, :latitude, :float
    add_column :offers, :longitude, :float
  end
end
