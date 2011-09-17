import_js = Rails.root + "lib/mongo_functions.js"
MongoMapper.database.eval(import_js.read)
