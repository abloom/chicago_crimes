class DensitiesController < ApplicationController
  def index
    data = Density.all.map do |d|
      {
        x: d.x,
        y: d.y,
        coordinates: Bounds.box(d.x, d.y, 100),
        incidents: d.total
      }
    end

    render json: data
  end
end
