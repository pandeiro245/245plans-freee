require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class Company < ActiveRecord::Base
    include HareruyaFreee::FreeeSync
    
    def self.check
      HareruyaFreee::Freee.check(self)
    end
  end
end
