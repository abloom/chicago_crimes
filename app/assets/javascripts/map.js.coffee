class window.Map extends Backbone.View
  render: ->
    bounds = @options.bounds
    latC   = bounds.max.latitude - bounds.min.latitude
    latC   = (latC/2) + bounds.min.latitude
    longC  = bounds.max.longitude - bounds.min.longitude
    longC  = (longC/2) + bounds.min.longitude

    options =
      zoom: 11,
      disableDefaultUI: true,
      zoomControl: true,
      center: @_latLng(latC, longC)
      mapTypeId: google.maps.MapTypeId.ROADMAP

    @map = new google.maps.Map(@el[0], options)
    if @options.drawBounds then @_drawBorder()

  _latLng: (latitude, longitude) ->
    new google.maps.LatLng(latitude, longitude)

  _drawBorder: ->
    bounds = @options.bounds
    @drawBox("#FF0000",
      bounds.max.latitude, bounds.min.latitude,
      bounds.max.longitude, bounds.min.longitude
    )

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
    box.setMap(@map)
    box
