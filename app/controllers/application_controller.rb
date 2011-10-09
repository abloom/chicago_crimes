class ApplicationController < ActionController::Base
  protect_from_forgery

  # Ensure the provided keys are in the params hash and return a 400 Bad
  # Request if they are not. Specify which controller actions the requirement
  # applies to using standard Rails before_filter options such as :only
  # or :except.
  #
  # Example:
  #   require_params :uuid, :name, :only => :create
  def self.require_params(*args)
    options = args.extract_options!
    before_filter(options) do |controller|
      head :bad_request if args.any? {|p| !controller.params[p]}
    end
  end

  def index
    @bounds = Bounds.values
  end
end
