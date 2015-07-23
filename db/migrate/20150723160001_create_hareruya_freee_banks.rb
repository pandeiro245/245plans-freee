class CreateHareruyaFreeeBanks < ActiveRecord::Migration
  def change
    create_table :hareruya_freee_banks do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
