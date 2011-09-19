class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @incidents = Incident.limit(20).all()
  end
end
