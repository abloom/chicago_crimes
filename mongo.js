var geoQuery = {
    location: {
      $within: {
        $box: [
          [41.73919130607693, -87.62686787107374],
          [41.74297575410407, -87.62276870779553]
        ]
      }
    }
  },
  map = function() {
    var data = {};

    data[this.charge] = 1;
    emit("25,75", data);
  },

  reduce = function(k, values) {
    var results = {};

    values.forEach(function(value) {
      var key;

      for(key in value) {
        if (value.hasOwnProperty(key)) {
          if (!results[key]) { results[key] = 0; }
          results[key] += value[key];
        }
      }
    });

    return results;
  };

count = db.incidents.count(geoQuery);
print(count); // => 564

results = db.runCommand({
  mapReduce: "incidents",
  map: map,
  reduce: reduce,
  out: "console",
  query: geoQuery
});

printjson(results);
