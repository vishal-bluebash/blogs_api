# frozen_string_literal: true

module RequestSpecHelper
  include JsonWebToken

  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def jwt_token(user)
    jwt_encode(user_id: user.id)
  end
end
