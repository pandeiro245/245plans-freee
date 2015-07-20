module The245plansFreee
  module FreeeSync
    extend ActiveSupport::Concern

    included do
      class << self
        def sync
          self.delete_all
          items = self.items
          if items.count == 100
            offset = 100
            while items.count > 0 do
              items = self.items offset
              offset += 100
            end
          end
        end

        def items offset = 0
          company_id = ENV['FREEE_COMPANY_ID']
          Freee.fetch(self, {
            company_id: company_id,
            offset: offset
          })
        end

        def import item
          item2 = self.find_or_create_by(
            id: item['id']
          )
          params = {}
          self.column_names.each do |param|
            params[param.to_sym] = item[param]
          end
          item2.update(
            params
          )
        end
      end
    end
  end
end
