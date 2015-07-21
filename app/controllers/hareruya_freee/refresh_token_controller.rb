require_dependency "hareruya_freee/application_controller"

module HareruyaFreee
  class RefreshTokenController < ApplicationController
    def index
      redirect_to "https://secure.freee.co.jp/oauth/authorize?client_id=#{ENV['FREEE_CLIENT_ID']}&redirect_uri=#{ENV['FREEE_CALLBACK_URL'].gsub(':', '%3A').gsub('/', '%2F')}&response_type=code"
    end

    def callback
      Freee.freee(params[:code])
      redirect_to '/freee/partners'
    end
  end
end
