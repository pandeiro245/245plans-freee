require_dependency "hareruya_freee/application_controller"

module HareruyaFreee
  class MonthsController < ApplicationController
    def show
      @month = Month.find(params[:id])
      render layout: 'application'
    end
  end
end
