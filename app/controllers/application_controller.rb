class ApplicationController < ActionController::Base
    
    before_action :authenticate_request
    attr_reader :current_user
    
    include ExceptionHandler

    private
    def authenticate_request
      unless session[:current_user]
        @current_user = AuthorizeApiRequest.call(request.headers).result
      else
        @current_user = session[:current_user]
      end
      render json: { error: 'Não autorizado' }, status: 401 unless @current_user
    end
end
