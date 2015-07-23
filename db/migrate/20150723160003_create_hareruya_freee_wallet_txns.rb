class CreateHareruyaFreeeWalletTxns < ActiveRecord::Migration
  def change
    create_table :hareruya_freee_wallet_txns do |t|
      t.date :date
      t.integer :amount
      t.integer :due_amount
      t.integer :balance
      t.string :entry_side
      t.string :walletable_type
      t.references :hareruya_freee_walletable, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
