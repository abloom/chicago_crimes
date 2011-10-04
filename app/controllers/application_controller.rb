class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @bounds = Bounds.values
  end
end
