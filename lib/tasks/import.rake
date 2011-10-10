desc "Import the CSV data"
task :import => :environment do
  require 'importer'
  Importer.run
end

namespace :density do
  desc "Calculate monthly densities"
  task :month => :environment do
    require 'density_calculator'
    DensityCalculator.run_month
  end

  desc "Calculate yearly densities"
  task :year => :environment do
    require 'density_calculator'
    DensityCalculator.run_year
  end
end
