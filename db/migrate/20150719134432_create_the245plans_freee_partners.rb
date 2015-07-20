class CreateThe245plansFreeePartners < ActiveRecord::Migration
  def change
    create_table :the245plans_freee_partners do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
