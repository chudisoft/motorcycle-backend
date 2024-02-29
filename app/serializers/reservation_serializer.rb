class ReservationSerializer
  include JSONAPI::Serializer
  attributes :reserve_time, :reserve_date, :quanity, :spicy_level
end
