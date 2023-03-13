class LocationsController < ApplicationController
  def index
    # res.render('index', templateVars)
    @locations = Location.all
  end
end
