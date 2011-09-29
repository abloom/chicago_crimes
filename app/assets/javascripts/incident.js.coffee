class window.Incident extends Backbone.Model
  initialize: (params) ->
    params.latitude  = params.location[0]
    params.longitude = params.location[1]
    delete params.location
    @set(params)

class window.IncidentCollection extends Backbone.Collection
  model: Incident
  url: "/incidents"

window.Incidents = new IncidentCollection
