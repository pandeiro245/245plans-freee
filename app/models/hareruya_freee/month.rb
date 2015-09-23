module HareruyaFreee
  class Month < ::Month
    def incomes
      WalletTxn.where(entry_side: 'income', date: first_date..last_date)
    end

    def expenses
      WalletTxn.where(entry_side: 'expense', date: first_date..last_date)
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
      res = [4409, 4411].map{|walletable_id|  # SBIと三井住友
        WalletTxn.where(entry_side: 'expense', date: first_date..last_date, hareruya_freee_walletable_id: walletable_id).last.balance
      }.reduce(:+)
      self.cols[:balance] = res
      self.save!
      res
    end

    def profit
      (income || 0 ) - (expense || 0)
    end

    def fetch_balance
      if future?
        prev.balance + profit
      else
        balance
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
