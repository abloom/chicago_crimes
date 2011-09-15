desc "Import the CSV data"
task :import => :environment do
  require 'importer'
  Importer.run
end
