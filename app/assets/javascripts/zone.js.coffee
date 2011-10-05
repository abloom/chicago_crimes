class window.Zone extends Backbone.Model
  total: ->
    _(@get("charges")).values().reduce((sum, count) ->
      sum + count
    , 0)

  drawBox: (map) ->
    coordinates = @get("coordinates")
    @box ||= map.drawBox("#0000FF",
      coordinates[0][0], coordinates[1][0],
      coordinates[0][1], coordinates[1][1]
    )

  highlight: ->
    @box.setOptions({fillOpacity: 0.15})

class window.ZoneCollection extends Backbone.Collection
  model: Zone
  initialize: (models, options) ->
    @date = options.date

  url: ->
    obj =
      date: "#{@date.getFullYear()}-#{@date.getMonth()+1}-#{@date.getDate()}"

    "/densities?#{$.param(obj)}"

  heatmapDataSet: ->
    set =
      max: 0
      data: []

    @forEach (zone) ->
      coords = zone.get("coordinates")
      data =
        lat: coords[0][0]
        lng: coords[0][1]
        count: zone.total()

      set.data.push(data)
      set.max = data.count if set.max < data.count

    set
