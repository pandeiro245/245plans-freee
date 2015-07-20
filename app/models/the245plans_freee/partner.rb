require 'app/models/the245plans_freee/concerns/freee_sync'
# TODO
# cannot load such file -- app/models/the245plans_freee/concerns/freee_sync

module The245plansFreee
  class Partner < ActiveRecord::Base
    has_many :deals, ->{order('due_date desc')}

    include The245plansFreee::FreeeSync

    def amount
      deals.map{|d| d.amount}.reduce(:+)
    end
  end
end
