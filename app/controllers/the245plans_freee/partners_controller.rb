require_dependency "the245plans_freee/application_controller"

module The245plansFreee
  class PartnersController < ApplicationController
    def index
      @partners = Partner.all
    end
  end
end
