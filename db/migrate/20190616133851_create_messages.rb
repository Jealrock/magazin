class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :text
      t.belongs_to :from_user
      t.belongs_to :to_user
      t.timestamps
    end
  end
end
