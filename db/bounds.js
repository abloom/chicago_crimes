m = function() {
  emit("minDate", this.date);
  emit("maxDate", this.date);

  emit("maxLatitude", this.location[0]);
  emit("minLatitude", this.location[0]);

  emit("maxLongitude", this.location[1]);
  emit("minLongitude", this.location[1]);
};

r = function(key, values) {
  var cleaned = [], func, value;

  values.forEach(function(value) {
    if (value && (value !== 0)) {
      if (key === "minDate" || key === "maxDate") { value = value.getTime(); }
      cleaned.push(value);
    }
  });

  if (/^min/.test(key)) {
    func = Math.min;
  } else {
    func = Math.max;
  }

  value = func.apply(Math, cleaned);
  if (key === "minDate" || key === "maxDate") { value = new Date(value); }
  return value;
};

db.runCommand({
  mapReduce: "incidents",
  map: m,
  reduce: r,
  out: "bounds"
});

db.bounds.insert({
  _id: "charges",
  value: db.incidents.distinct("charge").sort()
})
