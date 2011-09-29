class window.Zone extends Backbone.Model
  url: ->
    qs = $.param
      x1: @get("minLatitude")
      x2: @get("maxLatitude")
      y1: @get("minLongitude")
      y2: @get("maxLongitude")

    "/density?#{qs}"

  drawBox: ->
    @box ||= @get("map").drawBox("#0000FF",
      @get("minLatitude"), @get("maxLatitude"),
      @get("minLongitude"), @get("maxLongitude")
    )

  highlight: ->
    @box.setOptions({fillOpacity: 0.15})

class window.ZoneCollection extends Backbone.Collection
  model: Zone
