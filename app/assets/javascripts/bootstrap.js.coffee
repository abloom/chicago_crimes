$ ->
  App.updateZones()

  App.addView "map", new MapView
    el     : $("#map")
    bounds : App.bounds
    ready  : ->
      App.mapDidRender()

  App.addView "dateSlider", new DateSliderView
    el      : $("#date-control")
    minDate : App.bounds.minDate
    maxDate : App.bounds.maxDate

  App.addView "scaleControl", new ScaleControlsView
    el: $('#scale-control')
    scale: App.currentScale

  App.addView "debugControls", new DebugControlsView
    el: $('#debug-controls')
