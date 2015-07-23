require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class WalletTxn < ActiveRecord::Base
    belongs_to :walletable
    include HareruyaFreee::FreeeSync
  end
end
