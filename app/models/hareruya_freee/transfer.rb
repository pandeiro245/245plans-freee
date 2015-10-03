require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class Transfer < ActiveRecord::Base
    self.table_name = "transfers"
    include HareruyaFreee::FreeeSync
  end
end
