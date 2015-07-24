require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class AccountItem < ActiveRecord::Base
    include HareruyaFreee::FreeeSync
  end
end
