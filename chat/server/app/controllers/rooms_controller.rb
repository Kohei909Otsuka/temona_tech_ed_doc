class RoomsController < ApplicationController
  def index
    rooms = @current_user.rooms
    rs = RoomSerializer.new(rooms, {
      params: {current_user_id: @current_user.id}
    })

    render json: rs.serializable_hash, status: :ok
  end
end
