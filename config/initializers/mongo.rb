Incident.ensure_index :charge
Incident.ensure_index [[:location, "2d"]] # geo-spacial index
