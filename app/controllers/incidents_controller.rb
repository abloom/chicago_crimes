class IncidentsController < ApplicationController
  def density
    density = Incident.density_in_box(
      params[:x1].to_f, params[:x2].to_f,
      params[:y1].to_f, params[:y2].to_f)

    render json: density
  end
end
