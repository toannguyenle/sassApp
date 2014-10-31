class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  has_secure_password
  #brief time in RAM only a true password.
  # Hidden field
  # password
  # password_confirmation
  field :email, type: String
  field :is_admin, type: Mongoid::Boolean, default: false
  field :password_digest, type: String #hash to store encrypted password
end