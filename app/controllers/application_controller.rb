class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend
  protect_from_forgery with: :null_session
end
