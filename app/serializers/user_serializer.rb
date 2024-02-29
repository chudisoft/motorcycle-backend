class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :role, :name, :created_at
end
