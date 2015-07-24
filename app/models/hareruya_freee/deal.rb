require_dependency "hareruya_freee/concerns/freee_sync"
module HareruyaFreee
  class Deal < ActiveRecord::Base
    self.inheritance_column = "_type"
    include HareruyaFreee::FreeeSync
    store :info, accessors: [:details, :payments], coder: JSON
    belongs_to :partner, :class_name => 'HareruyaFreee::Partner', :foreign_key => :hareruya_freee_partner_id

    def partner_name
      partner ? partner.name : 'パートナー未設定'
    end

    def self.import deal
      deal2 = self.find_or_create_by(
        id: deal['id']
      )

      params = {}
      %w(
        issue_date
        due_date
        amount
        due_amount
        type
        hareruya_freee_partner_id
        ref_number
      ).each do |param|
        params[param.to_sym] = deal[param]
      end
      
      params[:details] = deal['details'].to_json

      deal2.update(
        params
      )
    end
  end
end
