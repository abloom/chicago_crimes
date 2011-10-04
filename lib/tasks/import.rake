desc "Import the CSV data"
task :import => :environment do
  require 'importer'
  Importer.run
end

desc "Calculate densities"
task :density => :environment do
  require 'density_calculator'
  DensityCalculator.run
end
