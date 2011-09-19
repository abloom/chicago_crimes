import_js = Rails.root + "lib/mongo_functions.js"
MongoMapper.database.eval(import_js.read)

Incident.ensure_index :charge
Incident.ensure_index [[:location, "2d"]] # geo-spacial index
