module HareruyaFreee
  class Month < ::Month
    def incomes
      if future?
        Deal.where(type: 'income', due_date: first_date..last_date) 
      else
        Deal.where(type: 'income', issue_date: first_date..last_date)
      end
    end

    def expenses
      Deal.where(type: 'expense', issue_date: first_date..last_date)
    end

    def income refresh = false
      if !refresh && cols && cols[:income]
        cols[:income]
      else
        self.cols ||= {}
        if !this_month? && future?
          res = Secretdata.incomes.values
        else
          res = incomes.map{|d| d.amount }
        end
        self.cols[:income] = res.reduce(:+) || 0
        self.save!
        self.cols[:income]
      end
    end

    def expense
      cols && cols[:expense] ? cols[:expense] : nil
    end

    def balance
      cols && cols[:balance] ? cols[:balance] : nil
    end

    def profit
      (income || 0 ) - (expense || 0)
    end

    def fetch_by_walletable_id id
      target = WalletTxn.where(
        hareruya_freee_walletable_id: id,
        date: first_date..last_date,
      ).order('date desc').first
      target ? target.balance.to_i : 0
    end

    def fetch_balance
      if future?
        prev.balance + profit
      else
        [4409, 4411].map{|id|
          fetch_by_walletable_id(id)
        }.reduce(:+)
      end
    end

    def self.sync
      self.order('first_date asc').each do |month|
        cols = {}
        cols[:income] = (month.future? ? Secretdata.incomes.values : month.incomes.map{|d| d.amount }).reduce(:+) || 0
        cols[:expense] = (month.future? ? Secretdata.expenses : month.expenses.map{|d| d.amount }).reduce(:+) || 0

        #cols[:profit] = month.profit
        cols[:profit] = (cols[:income] || 0 ) - (cols[:expense] || 0)

        cols[:profit] = cols[:income] - cols[:expense] if month.future?
        cols[:balance] = month.fetch_balance

        month.cols = cols

        month.save!
      end
    end
  end
end
