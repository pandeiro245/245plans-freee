require_dependency "the245plans_freee/application_controller"

module The245plansFreee
  class RefreshTokenController < ApplicationController
    def index
      redirect_to "https://secure.freee.co.jp/oauth/authorize?client_id=#{ENV['FREEE_CLIENT_ID']}&redirect_uri=http%3A%2F%2F245plans.dev%2Ffreee%2Fcallback&response_type=code"
    end

    def callback
      Freee.freee(params[:code])
      redirect_to '/freee/partners'
    end
  end
end
