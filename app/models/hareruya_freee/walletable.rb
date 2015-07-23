require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class Walletable < ActiveRecord::Base
    belongs_to :hareruya_free_bank
    include HareruyaFreee::FreeeSync
  end
end
