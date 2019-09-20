class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attribute :unread do |object, params|
    params[:unread_map][object.id] || 0
  end
end
