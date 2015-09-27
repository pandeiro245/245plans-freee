require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class WalletTxn < ActiveRecord::Base
    belongs_to :walletable
    include HareruyaFreee::FreeeSync

    def amt
      entry_side == 'expense' ? amount * -1 : amount
    end
  end
end
