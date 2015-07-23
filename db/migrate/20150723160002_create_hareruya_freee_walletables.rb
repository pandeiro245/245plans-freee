class CreateHareruyaFreeeWalletables < ActiveRecord::Migration
  def change
    create_table :hareruya_freee_walletables do |t|
      t.string :name
      t.string :type
      t.references :hareruya_freee_bank, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
