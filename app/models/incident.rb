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

  ensure_index :charge
  ensure_index [[:location, "2d"]] # geo-spacial index
end
