class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :check_is_admin
  def index
  end
end
