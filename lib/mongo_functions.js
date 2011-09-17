var s = db.system.js,
    code = [{
      _id: "mapper",
      value: function() {
        emit(this.charge, { count: 1 });
      }
    }, {
      _id: "reducer",
      value: function(k, values) {
        var results = { count: 0 };

        values.forEach(function(value) {
          results.count += value.count;
        });

        return results;
      }
    }];

// clear out functions and reload
s.remove({});
code.forEach(function(func) { s.save(func); });
