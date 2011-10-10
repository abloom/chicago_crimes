class window.Zone extends Backbone.Model
  total: ->
    _(@get("charges")).values().reduce((sum, count) ->
      sum + count
    , 0)

  centeredLongitude: ->
    coords = @get("coordinates")
    middle = (coords[1][1] - coords[0][1])/2.0
    middle + coords[0][1]

  centeredLatitude: ->
    coords = @get("coordinates")
    middle = (coords[1][0] - coords[0][0])/2.0
    middle + coords[0][0]

  drawBox: (map) ->
    @_box.setMap(null) if @_box

    coordinates = @get("coordinates")
    @_box = map.drawBox("#0000FF",
      coordinates[0][0], coordinates[1][0],
      coordinates[0][1], coordinates[1][1])

  hideBox: ->
    return unless @_box
    @_box.setMap(null)
    @_box = null

class window.ZoneCollection extends Backbone.Collection
  model: Zone

  initialize: (models, options) ->
    @date = options.date
    @scale = options.scale

  url: ->
    obj =
      date: "#{@date.getUTCFullYear()}-#{@date.getUTCMonth()+1}-#{@date.getUTCDate()}"
      scale: @scale

    "/densities?#{$.param(obj)}"

  heatmapDataSet: ->
    set =
      max: 0
      data: []

    @forEach (zone) ->
      data =
        lat: zone.centeredLatitude()
        lng: zone.centeredLongitude()
        count: zone.total()

      set.data.push(data)
      set.max = data.count if set.max < data.count

    set
