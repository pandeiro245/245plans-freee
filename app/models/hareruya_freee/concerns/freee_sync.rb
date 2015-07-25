module HareruyaFreee
  module FreeeSync
    extend ActiveSupport::Concern

    included do
      class << self
        def sync
          #self.delete_all
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
          HareruyaFreee::Freee.fetch(self, {
            company_id: HareruyaFreee::Freee.company_id,
            offset: offset
          })
        end

        def import item
          item2 = self.find_or_create_by(
            id: item['id']
          )
          params = {}
          self.column_names.each do |param|
            unless [:created_at, :updated_at].include?(param.to_sym)
              if param.match(/^hareruya_freee_/)
                val = item[param.gsub(/^hareruya_freee_/, '')]
              else
                val = item[param]
              end
              puts "key is #{param}"
              puts "val is #{val}"
              params[param.to_sym] = val
            end
          end
          item2.update(
            params
          )
        end
      end
    end
  end
end
