require_dependency "hareruya_freee/application_controller"

module HareruyaFreee
  class PlansController < ApplicationController
    def show
      @plan = Plan.find(params[:id])
      render layout: 'application'
    end
  end
end
