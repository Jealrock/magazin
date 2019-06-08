class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true
      t.belongs_to :offer, index: true
    end
  end
end
