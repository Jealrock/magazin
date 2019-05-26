class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.text :acquire_method
      t.float :price
      t.string :youtube_video_url
      t.string :address
      t.string :email
      t.string :phone_number
      t.boolean :is_comments_enable
      t.boolean :is_phone_number_visible
      t.timestamps
    end
  end
end
