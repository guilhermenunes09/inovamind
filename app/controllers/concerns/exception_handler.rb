module ExceptionHandler
  extend ActiveSupport::Concern
  class DecodeError < StandardError; end
  class ExpiredSignature < StandardError; end
  included do
    rescue_from ExceptionHandler::DecodeError do |_error|
      render json: {
        message: "Accesso Negado!. Token Inválido."
      }, status: :unauthorized
    end
    rescue_from ExceptionHandler::ExpiredSignature do |_error|
      render json: {
        message: "Access Negado!. Token expirado."
      }, status: :unauthorized
    end
  end
end