module HareruyaFreee
  module ApplicationHelper
    def freee_details details
      #return details
      JSON.parse(details).map do |i| 
        res = AccountItem.find(i['account_item_id']).name
        res += "：#{i['description']}(#{i['amount']}円)" if i['description']
        res
      end.join('<br>').html_safe
    end 

    def namelist(array)
      content_tag(:ul, 
        array.map{|item| 
          content_tag(:li, 
            link_to(item.name, item)
          )
        }.join.html_safe
      )
    end
  end
end
