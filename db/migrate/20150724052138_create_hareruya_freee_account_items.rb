class CreateHareruyaFreeeAccountItems < ActiveRecord::Migration
  def change
    create_table :hareruya_freee_account_items do |t|
      t.string :name
      t.text :categories

      t.timestamps null: false
    end
  end
end
