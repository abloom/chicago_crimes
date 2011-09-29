m = function() {
  emit("maxLatitude", this.location[0]);
  emit("minLatitude", this.location[0]);

  emit("maxLongitude", this.location[1]);
  emit("minLongitude", this.location[1]);
};

r = function(key, values) {
  var cleaned = [], func;

  switch(key) {
    case "maxLatitude":
    case "maxLongitude":
      func = Math.max;
      break;
    case "minLatitude":
    case "minLongitude":
      func = Math.min;
      break;
  }

  values.forEach(function(value) {
    if (value !== 0) {
      cleaned.push(value);
    }
  });

  return func.apply(Math, cleaned);
};

db.runCommand({
  mapReduce: "incidents",
  map: m,
  reduce: r,
  out: "bounds"
});
