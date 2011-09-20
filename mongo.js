m = function() {
  emit("location", {
    max: {
      latitude: this.location[0],
      longitude: this.location[1]
    },
    min: {
      latitude: this.location[0],
      longitude: this.location[1]
    }
  });
};

r = function(key, values) {
  var bounds = {
    max: { latitude: -200, longitude: -200 },
    min: { latitude: 200,  longitude: 200 }
  };

  values.forEach(function(value) {
    if ((value.max.latitude !== 0) &&
        (value.max.latitude > bounds.max.latitude)) {
      bounds.max.latitude = value.max.latitude;
    }

    if ((value.min.latitude !== 0) &&
        (value.min.latitude < bounds.min.latitude)) {
      bounds.min.latitude = value.min.latitude;
    }

    if ((value.max.longitude !== 0) &&
        (value.max.longitude > bounds.max.longitude)) {
      bounds.max.longitude = value.max.longitude;
    }

    if ((value.min.longitude !== 0) &&
        (value.min.longitude < bounds.min.longitude)) {
      bounds.min.longitude = value.min.longitude;
    }
  });

  return bounds;
};

printjson(db.runCommand({
  mapReduce: "incidents",
  map: m,
  reduce: r,
  out: "bounds"
}));
