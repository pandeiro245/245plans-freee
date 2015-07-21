class RenameFrom245plansToHareruya < ActiveRecord::Migration
  def change
    rename_table :the245plans_freee_partners, :hareruya_freee_partners
  end
end
