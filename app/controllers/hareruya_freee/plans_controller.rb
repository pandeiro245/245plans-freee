require_dependency "hareruya_freee/application_controller"

module HareruyaFreee
  class PlansController < ApplicationController
    def index
      @plan = Plan.find(1)
      render 'show', layout: 'application'
    end

    def show
      @plan = Plan.find(params[:id])
      render layout: 'application'
    end
  end
end
