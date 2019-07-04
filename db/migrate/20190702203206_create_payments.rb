class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :name
      t.integer :amount
      t.integer :megakassa_id
      t.integer :megakassa_order_id
      t.float :price

      t.string :type, null: false
      t.string :status, null: false, default: Payment::STATUSES.first
      t.jsonb :params, null: false, default: '{}'
      t.string :payable_entity_type
      t.belongs_to :payable_entity
      t.timestamps
    end
  end
end
