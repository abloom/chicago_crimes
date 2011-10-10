class window.DebugControlsView extends Backbone.View
  events: {
    "click :checkbox[name='zone-box']": 'zoneBoxDidToggle'
  }

  zoneBoxDidToggle: (evt) ->
    [cmd, arg] = if $(evt.target).attr("checked")
      ["drawBox", @options.map]
    else
      ["hideBox"]

    App.zones.forEach (z) ->
      z[cmd](arg)
