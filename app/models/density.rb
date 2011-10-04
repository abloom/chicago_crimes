class Density
  include MongoMapper::Document

  ensure_index :'value.start_date'
  ensure_index :'value.end_date'
  ensure_index [[:'values.bounds.location', "2d"]]

  key :value

  def x
    _id.split(",")[0].to_i
  end

  def y
    _id.split(",")[1].to_i
  end

  def charges
    value.keys
  end

  def incidents(charge)
    value[charge].to_i
  end

  def total
    value.values.sum.to_i
  end
end
