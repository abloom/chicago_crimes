class DensitiesController < ApplicationController
  require_params :date, :scale, :only => :index

  def index
    y, m, d = params[:date].split("-")
    time = Time.utc(y, m, d)
    densities = Density.by_date(time)

    render json: serialize(densities)
  end

private
  def serialize(objs)
    objs.map do |obj|
      {
        coordinates: obj.coordinates,
        charges: obj.charges
      }
    end
  end
end
