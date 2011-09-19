class Map extends Backbone.View
  #initialize: ->
    #@options.incidents.bind "add", @render, @

  render: ->
    options =
      zoom: 10,
      center: new google.maps.LatLng(41.90, -87.65)
      mapTypeId: google.maps.MapTypeId.ROADMAP

    @map = new google.maps.Map(@el[0], options)
    @options.incidents.each(((incident) ->
      @_createMarker(incident)), @)

  _createMarker: (incident) ->
    new google.maps.Marker(
      map: @map
      position: new google.maps.LatLng(
        incident.get("latitude"),
        incident.get("longitude")
      )
    )

$ ->
  # render the initial map
  window.map = new Map
    incidents: incidents
    el: $('#map')

  window.map.render()

