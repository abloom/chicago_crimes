var s = db.system.js,
    code = [{
      _id: "mapper",
      value: function() {

      }
    }, {
      _id: "reducer",
      value: function() {

      }
    }];

// clear out functions and reload
s.remove({});
code.forEach(function(func) { s.save(func); });
