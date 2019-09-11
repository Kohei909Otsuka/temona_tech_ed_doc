class RoomsController < ApplicationController
  def index
    rooms = @current_user.rooms
    hash = RoomSerializer.new(rooms).serializable_hash
    render json: hash, status: :ok
  end
end
