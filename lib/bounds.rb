# The Bounds module should produce four methods
#   max_latitude
#   max_longitude
#   min_latitude
#   min_longitude
#
# For this module to function properly you must run the db/bounds.js script
# against a loaded database
module Bounds
  extend ActiveSupport::Memoizable
  extend self

  MongoMapper.database['bounds'].find.to_a.each do |hsh|
    define_method(hsh["_id"].underscore) { hsh["value"] }
  end

  # Returns a 2 dimensional array of coordinates [lat, long] going from 0 to
  # divisions inclusive. the grid is determined by the number of divisions and
  # is bounded by min and max bounds held by this module
  def grid(divisions = 10)
    lat_distance = max_latitude - min_latitude
    long_distance = max_longitude - min_longitude
    grid = []

    (0..divisions).each do |x|
      latitude = ((x.to_f/divisions.to_f) * lat_distance) + min_latitude
      grid[x] = []

      (0..divisions).each do |y|
        longitude = ((y.to_f/divisions.to_f) * long_distance) + min_longitude
        grid[x][y] = [latitude, longitude]
      end
    end

    return grid
  end
  memoize :grid

  def box(x, y)
    [
      grid[x][y],
      grid[x+1][y+1]
    ]
  end
end
