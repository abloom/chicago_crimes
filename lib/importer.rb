require 'csv'

module Importer
  extend self

  CSVPath = Rails.root + "vendor/rows.csv"

  def run
    CSV.foreach(CSVPath) do |row|
    end
  end
end
