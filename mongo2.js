geoQuery = {
  location: {
    $within: {
      $box: [
        [ 41.98518042784104, -87.68835532024703 ],
        [ 42.02302490811244, -87.64736368746483 ]
      ]
    }
  }
};

map = function() {
  emit(this.charge, 1);
};

reduce = function(k, values) {
  var results = 0, i;
  for(i = 0; i < values.length; i++) {
    results += values[i];
  }
  return results;
};

count = db.incidents.count(geoQuery);
print(count)

results = db.runCommand({
  mapReduce: "incidents",
  map: map,
  reduce: reduce,
  out: "console",
  query: geoQuery
});

printjson(results);
