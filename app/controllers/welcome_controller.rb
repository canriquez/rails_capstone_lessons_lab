class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show ]
  def index; end
end
