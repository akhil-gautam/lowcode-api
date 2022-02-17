class ApplicationController < ActionController::API
  before_action :authorize_request, except: [:time]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from UnauthorizedError, with: :unauthorized_access

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    if header
    begin
      decoded = JsonWebToken.decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      raise UnauthorizedError
    rescue JWT::DecodeError => e
      render json: { errors: 'Session expired. Please login again!' }, status: :unauthorized
    end
    else
      raise UnauthorizedError
    end
  end

  
  def time
    render json: {time: DateTime.now}
  end

  private

  def record_not_found
    render json: { message: 'Record not found!'}, status: :unprocessable_entity
  end

  def unauthorized_access
    render json: { message: 'Unauthorized access!' }, status: :unprocessable_entity
  end
end
