require 'digest/sha1'

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

  class << self
    def density_in_box(x1, x2, y1, y2)
      sha1 = Digest::SHA1.hexdigest [x1, x2, y1, y2].join(" ")

      collection.map_reduce(mapper, reducer, {
        :query => {
          :location => {
            :$within => {
              :$box => [[x1, y1], [x2, y2]]
            }
          }
        },
        out: "density_#{sha1}"
      }).find.to_a
    end

  private
    def mapper
      <<-JS
      function() {
        emit(this.charge, { count: 1 });
      }
      JS
    end

    def reducer
      <<-JS
      function(k, values) {
        var results = 0;

        values.forEach(function(value) {
          results += value.count;
        });

        return { count: results };
      }
      JS
    end
  end
end
