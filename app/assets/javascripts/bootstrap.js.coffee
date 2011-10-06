window.App = {}

$ ->
  startDate = new Date(App.boundsData.minDate)
  window.zones = new ZoneCollection([], date: startDate)

  window.map = new MapView
    el         : $("#map")
    bounds     : App.boundsData

  window.dateSlider = new DateSliderView
    el      : $("#date-control")
    minDate : startDate
    maxDate : new Date(App.boundsData.maxDate)

  window.debugControls = new DebugControlsView
    el    : $('#debug-controls')
    map   : map
    zones : zones

  map.bind "ready", ->
    zones.fetch
      success: ->
        map.setHeatmapDataSet(zones.heatmapDataSet())

  debugControls.render()
  dateSlider.render()
  map.render()
