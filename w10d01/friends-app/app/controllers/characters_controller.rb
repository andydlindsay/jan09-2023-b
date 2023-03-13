class CharactersController < ApplicationController
  def index
    # location_id = req.params.location_id
    location_id = params[:location_id]
    @location = Location.find(location_id)
    @characters = @location.characters

    render json: {
      characters: @characters,
      location: @location
    }
  end
end
