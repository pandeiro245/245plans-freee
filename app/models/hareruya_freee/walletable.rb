require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class Walletable < ActiveRecord::Base
    self.inheritance_column = "_type"
    belongs_to :hareruya_free_bank
    include HareruyaFreee::FreeeSync

    def self.actives
      self.all.select{|h| ![4410, 4080].include?(h.id)}
    end
  end
end
