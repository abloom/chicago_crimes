$ ->
  bounds =
    max:
      latitude: Map.boundsData.maxLatitude,
      longitude: Map.boundsData.maxLongitude
    min:
      latitude: Map.boundsData.minLatitude,
      longitude: Map.boundsData.minLongitude

  window.map = new Map
    el: $('#map'),
    bounds: bounds
    #drawBounds: true,

  map.render()

  # FIXME why dont you get triggered when fetch is called?
  #Zones.bind("add", (zone) ->
  #  zone.drawBox(map)
  #  zone.highlight()
  #)

  Zones.fetch(
    # TODO this goes away if I can figure out why binding to add doesnt work
    success: ->
      Zones.forEach((zone) ->
        zone.drawBox(map)
        zone.highlight()
      )
  )
