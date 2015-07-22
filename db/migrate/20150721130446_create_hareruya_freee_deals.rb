class CreateHareruyaFreeeDeals < ActiveRecord::Migration
  def change
    create_table :hareruya_freee_deals do |t|
      t.date :issue_date
      t.date :due_date
      t.integer :amount
      t.integer :due_amount
      t.string :type
      t.references :hareruya_freee_partner, index: true, foreign_key: true
      t.string :ref_number
      t.text :info

      t.timestamps null: false
    end
  end
end
