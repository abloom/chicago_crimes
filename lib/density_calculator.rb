require 'progressbar'

module DensityCalculator
  extend self

  def run(divisions = 100)
    days = (Bounds.min_date.to_time - Bounds.max_date.to_time).abs/86400
    date = Bounds.min_date.beginning_of_month
    pb = ProgressBar.new("Densities", divisions*divisions*(days/30))

    while(date < Bounds.max_date) do
      end_of_month = date.end_of_month

      0.upto(divisions-1) do |x|
        0.upto(divisions-1) do |y|
          coll = Incident.density_in_cell_for_day_range(x, y, divisions, date, end_of_month)
          pb.inc
        end
      end

      date = date.next_month
    end

    pb.finish
  end
end
