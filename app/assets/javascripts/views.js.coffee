class window.DateSliderView extends Backbone.View
  minYear: ->
    @options.minDate.getFullYear()

  maxYear: ->
    @options.maxDate.getFullYear()

  render: ->
    @$('#date').text(2001)

    @_slider = @$('#slider').slider
      value : @minYear()
      min   : @minYear()
      max   : @maxYear()
      step  : 1

class window.DebugControlsView extends Backbone.View
  events: {
    "click :checkbox[name='zone-box']": 'zoneBoxDidToggle'
    "click :checkbox[name='border-box']": 'borderBoxDidToggle'
  }

  borderBoxDidToggle: (evt) ->
    cmd = if $(evt.target).attr("checked")
      "drawBorder"
    else
      "hideBorder"

    @options.map[cmd]()

  zoneBoxDidToggle: (evt) ->
    [cmd, arg] = if $(evt.target).attr("checked")
      ["drawBox", @options.map]
    else
      ["hideBox"]

    @options.zones.forEach (z) ->
      z[cmd](arg)

