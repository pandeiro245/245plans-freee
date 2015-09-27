class CreateTransfer < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :company_id
      t.date :date
      t.integer :amount
      t.string :from_walletable_type
      t.integer :from_walletable_id
      t.string :to_walletable_type
      t.integer :to_walletable_id
      t.text :description
    end
  end
end
