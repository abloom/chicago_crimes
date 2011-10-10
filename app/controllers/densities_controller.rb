class DensitiesController < ApplicationController
  require_params :date, :scale, :only => :index

  def index
    y, m, d = params[:date].split("-")
    time = Time.utc(y, m, d)
    densities = density.by_date(time)

    render json: serialize(densities)
  end

private
  def density
    return case params[:scale]
    when "year"
      YearDensity
    when "month"
      MonthDensity
    end
  end

  def serialize(objs)
    objs.map do |obj|
      {
        coordinates: obj.coordinates,
        charges: obj.charges
      }
    end
  end
end
