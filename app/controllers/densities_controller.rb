class DensitiesController < ApplicationController
  def index
    y, m, d = params[:date].split("-")
    time = Time.utc(y, m, d)
    render json: serialize(Density.by_date(time))
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
