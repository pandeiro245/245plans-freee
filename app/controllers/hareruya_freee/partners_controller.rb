require_dependency "hareruya_freee/application_controller"

module HareruyaFreee
  class PartnersController < ApplicationController
    def index
      @partners = Partner.all
      render layout: 'application'
    end

    def show
      @partner = Partner.find(params[:id])
    end
  end
end
