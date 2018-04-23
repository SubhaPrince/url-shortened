class ApplicationController < ActionController::Base
  before_action :set_host_with_port
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_host_with_port
    Url.host_with_port = request.host_with_port
  end
end
