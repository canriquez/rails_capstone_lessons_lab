class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  def index; end
end
