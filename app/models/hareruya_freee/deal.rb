require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class Deal < ActiveRecord::Base
    self.inheritance_column = "_type"
    include HareruyaFreee::FreeeSync
    belongs_to :hareruya_freee_partner
  end
end
