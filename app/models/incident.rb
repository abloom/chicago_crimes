class Incident
  include MongoMapper::Document

  key :date, Date
  key :charge, String
  key :description, String
  key :arrest, Boolean
  key :domestic, Boolean
  key :beat, Integer
  key :ward, Integer
  key :latitude, Float
  key :longitude, Float
end
