class Map extends Backbone.View
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
    if @options.drawGrid   then @_drawGrid()

  zones: ->
    return @_zones if @_zones

    @_zones = []
    bounds = @options.bounds
    latInterval = (bounds.max.latitude - bounds.min.latitude) / @options.divisions
    longInterval = (bounds.max.longitude - bounds.min.longitude) / @options.divisions

    [0..@options.divisions-1].forEach((x) ->
      @_zones[x] = []
      minLat = bounds.min.latitude + (x * latInterval)
      maxLat = bounds.min.latitude + ((x+1) * latInterval)

      [0..@options.divisions-1].forEach((y) ->
        minLong = bounds.min.longitude + (y * longInterval)
        maxLong = bounds.min.longitude + ((y+1) * longInterval)

        @_zones[x][y] = new Zone(
          map: @,
          minLatitude: minLat
          maxLatitude: maxLat
          minLongitude: minLong
          maxLongitude: maxLong)
        @_zones[x][y].fetch()
      ,@)
    ,@)

    @_zones

  zone: (x, y) ->
    @zones()[x][y]

  _latLng: (latitude, longitude) ->
    new google.maps.LatLng(latitude, longitude)

  _drawGrid: ->
    [0..@options.divisions-1].forEach((x) ->
      [0..@options.divisions-1].forEach((y) ->
        @zone(x,y).drawBox()
      ,@)
    ,@)

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

$ ->
  bounds =
    max:
      latitude: 42.02302490811244
      longitude: -87.52438878911826
    min:
      latitude: 41.64458010539843
      longitude: -87.93430511694018

  window.map = new Map
    el: $('#map'),
    #drawBounds: true,
    drawGrid: true,
    divisions: 10,
    bounds: bounds

  map.render()
