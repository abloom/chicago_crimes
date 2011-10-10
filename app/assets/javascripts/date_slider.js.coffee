class window.DateSliderView extends Backbone.View
  initialize: ->
    App.bind("change:currentDate", ->
      year = @currentYear()
      @_slider.slider("value", year)
      @renderDate(year)
    , @)

  currentYear: ->
    App.currentDate.getFullYear()

  minYear: ->
    @options.minDate.getFullYear()

  maxYear: ->
    @options.maxDate.getFullYear()

  renderDate: (year) ->
    @$('#date').text(year)

  render: ->
    year = @currentYear()
    @renderDate(year)
    @$('#min-date').text(@minYear())
    @$('#max-date').text(@maxYear())

    @_slider = @$('#slider').slider
      value : year
      min   : @minYear()
      max   : @maxYear()
      step  : 1
      slide : (evt, ui) =>
        # update the ui constantly
        @renderDate(ui.value)
      stop  : (evt, ui) ->
        # only update the controller when we're done
        App.setCurrentYear(ui.value)
