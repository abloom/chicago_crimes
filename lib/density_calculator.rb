require 'progressbar'

module DensityCalculator
  extend self

  def run_year
    run(:year)
  end

  def run_month
    run(:month)
  end

  def run(scale, divisions = 50)
    pb = ProgressBar.new("#{scale.capitalize} Densities", divisions*divisions*increments(scale))
    range = next_range(scale)
    count = 0

    while(range[0] < Bounds.max_date) do
      0.upto(divisions-1) do |x|
        0.upto(divisions-1) do |y|
          coll = Incident.density_in_cell_for_day_range(
            x, y,
            divisions,
            range[0],
            range[1],
            scale)

          pb.inc
        end
      end

      range = next_range(scale, range)
      count += 1
    end

    pb.finish
  end

  def next_range(scale, previous = false)
    start = if previous
      previous[0].send("next_#{scale}".to_sym)
    else
      Bounds.min_date
    end

    return [
      start,
      start.send("end_of_#{scale}".to_sym)
    ]
  end

  def increments(scale)
    inc = Bounds.max_date.year - Bounds.min_date.year
    inc += 1
    inc *= 12 if scale == :month
    inc
  end
end
