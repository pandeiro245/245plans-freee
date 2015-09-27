require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class Transfer < ActiveRecord::Base
    include HareruyaFreee::FreeeSync
  end
end
