class DensitiesController < ApplicationController
  def index
    date = Date.parse(params[:date]).to_time
    render json: serialize(Density.by_date(date))
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
