require 'progressbar'

module DensityCalculator
  extend self

  def run(divisions = 50)
    start_date = Bounds.min_date.beginning_of_year
    increments = Bounds.max_date.year - Bounds.min_date.year
    pb = ProgressBar.new("Densities", divisions*divisions*increments)

    while(start_date < Bounds.max_date) do
      end_date = start_date.end_of_year

      0.upto(divisions-1) do |x|
        0.upto(divisions-1) do |y|
          coll = Incident.density_in_cell_for_day_range(x, y, divisions, start_date, end_date)
          pb.inc
        end
      end

      start_date = start_date.next_year
    end

    pb.finish
  end
end
