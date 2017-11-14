module AuthHelper
  def auth_request(user = false)
    request.headers.merge!(user.create_new_auth_token)
  end
end
