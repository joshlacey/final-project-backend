class ApplicationController < ActionController::API
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # include ApplicationController::JWT
  before_action :authorized





  def issue_token(payload)
    token = JWT.encode(payload, "pickle")
  end

  def auth_header
    header = request.headers['Authorization']
  end


  # def current_user
  #   authenticate_or_request_with_http_token do |jwt_token, options|
  #     begin
  #       decoded_token = JWT.decode(jwt_token, "pickle")
  #
  #     rescue JWT::DecodeError
  #       return nil
  #     end
  #
  #     if decoded_token[0]["user_id"]
  #       @current_user ||= User.find(decoded_token[0]["user_id"])
  #     else
  #     end
  #   end
  # end




  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, "pickle", true, {algorithm: 'HS256'})
      rescue JWT::DecodeError
        [{}]
      end
    else
    end
  end

    def current_user
      if decoded_token
        if user_id = decoded_token[0]["user_id"]
          @user = User.find(user_id)
        else
        end
      else
      end
    end


  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: "Please Login" }, status: 401 unless logged_in?
  end

end