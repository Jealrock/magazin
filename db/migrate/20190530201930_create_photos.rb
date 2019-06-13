class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :file
      t.belongs_to :offer
      t.timestamps
    end
  end
end
