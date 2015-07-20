require_dependency "the245plans_freee/application_controller"

module The245plansFreee
  class PartnersController < ApplicationController
    before_action :set_partner, only: [:show, :edit, :update, :destroy]

    def index
      @partners = Partner.all
    end
  end
end
