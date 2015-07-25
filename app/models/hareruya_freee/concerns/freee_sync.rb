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

        def import raw_data
          instance = self.find_or_create_by(
            id: raw_data['id']
          )
          params = {}
          self.column_names.each do |param|
            raise params.inspect
            unless [:created_at, :updated_at].include?(param.to_sym)
              if param.match(/^hareruya_freee_/)
                val = raw_data[param.gsub(/^hareruya_freee_/, '')]
              else
                val = raw_data[param]
              end
              params[param.to_sym] = val
            end
          end
          instance.update(
            params
          )
        end
      end
    end
  end
end
