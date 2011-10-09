class Density
  class Value
    class Bound
      include MongoMapper::EmbeddedDocument
      key :name
      key :location, Array
    end

    include MongoMapper::EmbeddedDocument
    key :x, Integer
    key :y, Integer
    key :start_date, Date
    key :end_date, Date
    key :charges, Hash

    many :bounds, :class => Bound

    def total
      charges.values.sum.to_i
    end

    def coordinates
      [bounds.first.location, bounds.last.location]
    end
  end

  include MongoMapper::Document

  ensure_index :'value.start_date'
  ensure_index :'value.end_date'
  one :value, :class => Value

  delegate :x, :y, :start_date, :end_date, :charges, :total, :coordinates,
    :to => :value

  def self.by_date(date)
    where(:'value.start_date'.lte => date, :'value.end_date'.gte => date)
  end
end

class YearDensity < Density
  set_collection_name "year.densities"
end

class MonthDensity < Density
  set_collection_name "month.densities"
end
