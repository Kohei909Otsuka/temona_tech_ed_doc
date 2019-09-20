class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attribute :unread do |object, params|
    object.unread_msgs
      .where(user_id: params[:current_user_id])
      .count
  end
end
