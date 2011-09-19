class Map extends Backbone.View
  initialize: ->
    Incidents.bind "add", @addOne, @
    Incidents.bind "reset", @addAll, @

    Incidents.fetch()

  addAll: ->
    Incidents.each(@addOne, @)

  addOne: (incident) ->
    @_createMarker(incident)

  render: ->
    options =
      zoom: 10,
      center: new google.maps.LatLng(41.90, -87.65)
      mapTypeId: google.maps.MapTypeId.ROADMAP

    @map = new google.maps.Map(@el[0], options)

  _createMarker: (incident) ->
    new google.maps.Marker(
      map: @map
      position: new google.maps.LatLng(
        incident.get("latitude"),
        incident.get("longitude")
      )
    )

$ ->
  window.map = new Map
    el: $('#map')

  window.map.render()

