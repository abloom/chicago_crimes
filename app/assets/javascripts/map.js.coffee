class window.MapView extends Backbone.View
  render: ->
    bounds = @options.bounds
    latC   = bounds.maxLatitude - bounds.minLatitude
    latC   = (latC/2) + bounds.minLatitude
    longC  = bounds.maxLongitude - bounds.minLongitude
    longC  = (longC/2) + bounds.minLongitude

    options =
      zoom: 11,
      disableDefaultUI: true,
      disableDoubleClickZoom: true,
      draggable: false,
      keyboardShortcuts: false,
      mapTypeControl: false,
      scrollwheel: false,
      center: @_latLng(latC, longC)
      mapTypeId: google.maps.MapTypeId.ROADMAP

    @_map = new google.maps.Map(@el[0], options)
    @_heatmap = new HeatmapOverlay(@_map, {
      radius  : 9,
      visible : true,
      opacity : 70
    });

    if @options.drawBounds then @drawBorder()

    google.maps.event.addListenerOnce(@_map, "idle", =>
      @trigger("ready")
    )

  _latLng: (latitude, longitude) ->
    new google.maps.LatLng(latitude, longitude)

  drawBorder: ->
    @_border.setMap(null) if @_border

    bounds = @options.bounds
    @_border = @drawBox("#FF0000",
      bounds.maxLatitude, bounds.minLatitude,
      bounds.maxLongitude, bounds.minLongitude
    )

  hideBorder: ->
    return unless @_border
    @_border.setMap(null)
    @_border = null

  drawBox: (color, lat1, lat2, long1, long2) ->
    boxCoords = [
      @_latLng(lat1, long1),
      @_latLng(lat2, long1),
      @_latLng(lat2, long2),
      @_latLng(lat1, long2)
    ]

    box = new google.maps.Polygon(
      paths: boxCoords,
      strokeColor: color,
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: color,
      fillOpacity: 0
    )
    box.setMap(@_map)
    box

  setHeatmapDataSet: (dataset) ->
    @_heatmap.setDataSet(dataset)
