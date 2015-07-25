module HareruyaFreee
  module FreeeSync
    extend ActiveSupport::Concern

    included do
      class << self
        def sync instance_id = nil
          if instance_id
            instance = self.find(instance_id) 
            params = {
              company_id: HareruyaFreee::Freee.company_id,
              offset: 0
            }
            [:type, :start_issue_date, :end_issue_date, :start_due_date, :end_due_date].each do |key|
              params[key] = instance.send(key) if instance.send(key)
            end
            HareruyaFreee::Freee.fetch(self, params)
          else # fetch all
            items = self.items
            if items.count == 100
              offset = 100
              while items.count > 0 do
                items = self.items offset
                offset += 100
              end
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
            key = param.gsub(/^hareruya_freee_/, '')
            unless [:created_at, :updated_at].include?(param.to_sym)
              val = raw_data[key]
              params[key.to_sym] = val
              puts "key is #{key}"
              puts "val is #{val}"
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
