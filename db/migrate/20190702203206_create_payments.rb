class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :megakassa_uid
      t.float :price
      t.string :type, null: false
      t.integer :status, null: false, default: 0 
      t.jsonb :params
      t.string :payable_entity_type
      t.belongs_to :payable_entity
      t.timestamps
    end
  end
end
