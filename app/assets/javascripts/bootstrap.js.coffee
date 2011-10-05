$ ->
  window.map = new Map
    el          : $('#map'),
    bounds      : Map.boundsData
    #drawBounds : true,

  window.zones = new ZoneCollection([], date: new Date(2011, 0, 1))
  map.render()
  map.bind "ready", ->
    zones.fetch
      success: ->
        map.setHeatmapDataSet(zones.heatmapDataSet())

