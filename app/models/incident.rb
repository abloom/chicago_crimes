class Incident
  include MongoMapper::Document

  key :case_number, Integer
  key :date, Date
  key :charge, String
  key :description, String
  key :arrest, Boolean
  key :domestic, Boolean
  key :beat, Integer
  key :ward, Integer
  key :location, Array

  ensure_index :date
  ensure_index :charge
  ensure_index [[:location, "2d"]] # geo-spacial index

  class << self
    def density_in_cell_for_day_range(x, y, divisions, date1, date2, scale)
      coordinates = Bounds.box(x, y, divisions)
      query = {
        :location => {
          :$within => {
            :$box => coordinates
          }
        },
        :date => {
          :$gte => date1,
          :$lte => date2
        }
      }

      map = mapper(x, y, date1, date2, coordinates)
      collection.map_reduce(map, reducer, {
        query: query,
        out: { merge: "#{scale}.densities" }
      })
    end

  private
    def cell_query(coordinates)
      query = {
        :location => {
          :$within => {
            :$box => coordinates
          }
        }
      }
    end

    def mapper(x, y, date1, date2, coordinates)
      sha = Digest::SHA1.hexdigest [x, y, date1.to_i, date2.to_i].join(",")
      data = {
        x: x,
        y: y,
        start_date: date1,
        end_date: date2,
        bounds: [{
          name: "min",
          location: coordinates[0]
        }, {
          name: "max",
          location: coordinates[1]
        }]
      }

      <<-JS
      function() {
        var data = #{data.to_json};

        data.start_date = ISODate(data.start_date);
        data.end_date = ISODate(data.end_date);
        data.charges = {};
        data.charges[this.charge] = 1;

        emit("#{sha}", data);
      }
      JS
    end

    def reducer
      <<-JS
      function(k, values) {
        var results = values.pop(),
            charges = #{Bounds.charges.to_json};

        values.forEach(function(value) {
          var key;

          charges.forEach(function(charge) {
            if (value.charges[charge]) {
              if (!results.charges[charge]) { results.charges[charge] = 0; }
              results.charges[charge] += value.charges[charge];
            }
          });
        });

        return results;
      }
      JS
    end
  end
end
