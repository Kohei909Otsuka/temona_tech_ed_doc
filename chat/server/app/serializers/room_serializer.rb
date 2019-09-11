class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
