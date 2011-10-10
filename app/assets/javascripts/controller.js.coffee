class window.Controller extends Backbone.Router
  initialize: (options) ->
    @bounds = options.bounds
    @bounds.minDate = new Date(@bounds.minDate)
    @bounds.maxDate = new Date(@bounds.maxDate)
    @currentDate = @bounds.minDate
    @currentScale = "year"
    @views = {}

    @bind("change:currentScale", @setZones, @)
    @bind("change:currentDate", @setZones, @)

  setCurrentScale: (scale) ->
    @currentScale = scale
    @trigger("change:currentScale")

  setCurrentYear: (year) ->
    @currentDate = new Date(year, 0, 1)
    @trigger("change:currentDate")

  # adding a view to the App will automatically render it
  addView: (name, view) ->
    @views[name] = view
    view.render()

  # setting the Apps zone will automatically fetch it
  setZones: ->
    @zones = new ZoneCollection [],
      date: @currentDate
      scale: @currentScale

    @_zonesDidFetch = false
    @zones.fetch
      success: =>
        @zonesDidFetch()

  zonesDidFetch: ->
    @_zonesDidFetch = true
    @_drawHeatMap()

  mapDidRender: ->
    @_mapDidRender = true
    @_drawHeatMap()

  # make sure the map is ready and the zone is fetched before drawing the heat
  # map
  _drawHeatMap: ->
    return unless @_mapDidRender and @_zonesDidFetch
    @views['map'].setHeatmapDataSet(@zones.heatmapDataSet())
