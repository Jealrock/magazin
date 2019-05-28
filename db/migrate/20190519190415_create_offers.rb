class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.string :type, null: false
      t.belongs_to :user

      t.float :price
      t.string :exchange_item

      t.boolean :closed, default: false
      t.string :title
      t.text :description
      t.string :location
      t.string :email
      t.string :phone_number
      t.timestamps
    end

    add_index :offers, [:type]
  end
end
