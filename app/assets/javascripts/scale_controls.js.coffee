class window.ScaleControlsView extends Backbone.View
  events: {
    "click :radio[name='scale']": 'scaleDidChange'
  }

  initialize: ->
    App.bind("change:currentScale", @render, @)

  render: ->
    @$("#scale_year").attr("checked", App.currentScale == "year")
    @$("#scale_month").attr("checked", App.currentScale == "month")

  scaleDidChange: (evt) ->
    App.setCurrentScale $(evt.target).val()
