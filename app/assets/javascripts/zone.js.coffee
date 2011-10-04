class window.Zone extends Backbone.Model
  drawBox: (map) ->
    coordinates = @get("coordinates")
    @box ||= map.drawBox("#0000FF",
      coordinates[0][0], coordinates[1][0],
      coordinates[0][1], coordinates[1][1]
      #@get("minLatitude"), @get("maxLatitude"),
      #@get("minLongitude"), @get("maxLongitude")
    )

  highlight: ->
    @box.setOptions({fillOpacity: 0.15})

class ZoneCollection extends Backbone.Collection
  url: "/densities"
  model: Zone

window.Zones = new ZoneCollection
