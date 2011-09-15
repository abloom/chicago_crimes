require 'csv'
require 'progressbar'

module Importer
  extend self

  CSVPath = Rails.root + "vendor/rows.csv"

  def run
    count = `wc -l #{CSVPath}`.to_i
    pb = ProgressBar.new("Incidents", count)

    CSV.foreach(CSVPath, :headers => true) do |row|
      date = Date.strptime(row['Date'], "%m/%d/%Y")
      Incident.create!(
        :date        => date,
        :case_number => row['Case Number'],
        :charge      => row['Primary Type'],
        :description => row['Description'],
        :arrest      => row['Arrest'],
        :domestic    => row['Domestic'],
        :beat        => row['Beat'],
        :ward        => row['Ward'],
        :latitude    => row['Latitude'],
        :longitude   => row['Longitude'])
      pb.inc
    end

    pb.finish
  end
end
