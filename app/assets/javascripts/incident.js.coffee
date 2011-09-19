class window.Incident extends Backbone.Model
  initialize: (params) ->
    params.latitude  = params.location[0]
    params.longitude = params.location[1]
    delete params.location
    @set(params)

class Incidents extends Backbone.Collection
  model: Incident
  url: "/incidents"

window.incidents = new Incidents

$ ->
  # add all the Incident JSON to the incidents collection
  _(incidentData).each (obj) ->
    incidents.add new Incident(obj)
