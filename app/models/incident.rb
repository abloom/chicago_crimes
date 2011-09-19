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

  def self.reduce_in_range(center, distance)
    center_string = center.join("_").gsub(/-|\./, "_")
    output_collection = "reduced_incidents_#{center_string}_#{distance}"

    collection.map_reduce("mapper", "reducer", {
      :query => {
        :location => {
          :$near => center,
          :$maxDistance => distance
        }
      },
      out: output_collection
    })
  end
end
