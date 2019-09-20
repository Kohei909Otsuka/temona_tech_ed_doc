class RoomsController < ApplicationController
  def index
    rooms = @current_user.rooms
    rs = RoomSerializer.new(rooms, {
      params: {unread_map: unread_map}
    })

    render json: rs.serializable_hash, status: :ok
  end

  private

  def unread_map
    UnreadMsg
      .where(user_id: @current_user.id)
      .group(:room_id)
      .count
  end
end
