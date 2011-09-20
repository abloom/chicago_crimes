class Map extends Backbone.View
  initialize: ->
    Incidents.bind "add", @addOne, @
    Incidents.bind "reset", @addAll, @

  addAll: ->
    Incidents.each(@addOne, @)

  addOne: (incident) ->
    #@_createMarkerFromIncident(incident)

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
    if @options.markCenter then @_createMarker(latC, longC)
    if @options.drawBounds then @_drawBoundingBox()

  _createMarkerFromIncident: (incident) ->
    @_createMarker(
      incident.get("latitude"),
      incident.get("longitude")
    )

  _createMarker: (latitude, longitude) ->
    new google.maps.Marker(
      map: @map
      position: @_latLng(latitude, longitude)
    )

  _latLng: (latitude, longitude) ->
    new google.maps.LatLng(latitude, longitude)

  _drawBoundingBox: ->
    bounds = @options.bounds
    boxCoords = [
      @_latLng(bounds.max.latitude, bounds.max.longitude),
      @_latLng(bounds.min.latitude, bounds.max.longitude),
      @_latLng(bounds.min.latitude, bounds.min.longitude),
      @_latLng(bounds.max.latitude, bounds.min.longitude)
    ]

    @_boundingBox = new google.maps.Polygon(
      paths: boxCoords,
      strokeColor: "#FF0000",
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: "#FF0000",
      fillOpacity: 0.15
    )
    @_boundingBox.setMap(@map)

$ ->
  window.map = new Map
    el: $('#map'),
    #markCenter: true,
    drawBounds: true,
    bounds:
      max:
        latitude: 42.02302490811244
        longitude: -87.52438878911826
      min:
        latitude: 41.64458010539843
        longitude: -87.93430511694018

  window.map.render()
  window.Incidents.fetch()
