module HareruyaFreee
  class Month < ::Month

    def self.refresh!
      self.order('id asc').each do |month|
        month.refresh!
      end
    end

    def refresh!
      self.income(true)
      self.expense(true)
      self.balance
    end

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

    def expense refresh = false
      if !refresh && cols && cols[:expense]
        cols[:expense]
      else
        self.cols ||= {}
        if !this_month? && future?
          res = Secretdata.expenses.values
        else
          res = expenses.map{|d| d.amount }
        end
        self.cols[:expense] = res.reduce(:+) || 0
        self.save!
        self.cols[:expense]
      end
    end

    def balance
      if future?
        if prev
          res = prev.balance + profit
        else
          res = 0
        end
      else
        res = [4409, 4411].map{|walletable_id|  # SBIと三井住友
          txns = WalletTxn.where(entry_side: 'expense', date: first_date..last_date, hareruya_freee_walletable_id: walletable_id)
          txns.present? ? txns.last.balance : 0
        }.reduce(:+)

      end
      self.cols[:balance] = res
      self.save!
      res
    end

    def profit
      (income || 0 ) - (expense || 0)
    end

    def self.sync
      self.order('first_date asc').each do |month|
        cols = {}
        cols[:income] = (month.future? ? Secretdata.incomes.values : month.incomes.map{|d| d.amount }).reduce(:+) || 0
        cols[:expense] = (month.future? ? Secretdata.expenses : month.expenses.map{|d| d.amount }).reduce(:+) || 0

        #cols[:profit] = month.profit
        cols[:profit] = (cols[:income] || 0 ) - (cols[:expense] || 0)

        cols[:profit] = cols[:income] - cols[:expense] if month.future?
        cols[:balance] = month.balance

        month.cols = cols

        month.save!
      end
    end
  end
end
