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
print(count); // => 119230

results = db.runCommand({
  mapReduce: "incidents",
  map: map,
  reduce: reduce,
  out: "console",
  query: geoQuery
});

printjson(results);

/** output
{
  "assertion" : "internal error: locks are not upgradeable: { \"opid\" : 17, \"active\" : true, \"lockType\" : \"read\", \"waitingForLock\" : false, \"secs_running\" : 0, \"op\" : \"query\", \"ns\" : \"crime_maps_development.incidents\", \"query\" : { \"mapReduce\" : \"incidents\", \"map\" : function () {\n    emit(this.charge, 1);\n}, \"reduce\" : function (k, values) {\n    var results = 0, i;\n    for (i = 0; i < values.length; i++) {\n        results += values[i];\n    }\n    return results;\n}, \"out\" : \"console\", \"query\" : { \"location\" : { \"$within\" : { \"$box\" : [ [ 41.98518042784104, -87.68835532024703 ], [ 42.02302490811244, -87.64736368746483 ] ] } } } }, \"client\" : \"127.0.0.1:58690\", \"desc\" : \"conn\", \"threadId\" : \"0x10320a000\", \"connectionId\" : 3, \"msg\" : \"m/r: (1/3) emit phase 999/119230 0%\", \"progress\" : { \"done\" : 999, \"total\" : 119230 }, \"numYields\" : 0 }",
  "assertionCode" : 10293,
  "errmsg" : "db assertion failure",
  "ok" : 0
}
 **/
