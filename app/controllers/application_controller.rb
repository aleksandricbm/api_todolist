class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::MimeResponds
  include CanCan::ControllerAdditions
end
