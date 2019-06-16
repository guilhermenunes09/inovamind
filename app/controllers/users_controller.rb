class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:login, :register]
    skip_before_action :authenticate_request, only: [:login, :register]
    
    # POST /register
    def register
        @user = User.create(user_params)
        if @user.save
            response = { message: 'Usuário criado com sucesso!'}
            render json: response, status: :created 
        else
            render json: @user.errors, status: :bad
        end 
    end

    # POST /login
    # Ao logar passe um Header com key [Authorization] e um [Token] válido
    def login
        authenticate params[:email], params[:password]
    end

    private
    def user_params
        params.permit(
            :name,
            :email,
            :password
        )
    end

    def authenticate(email, password)
        command = AuthenticateUser.call(email, password)
    
        if command.success? || session[:current_user]
          user = User.where(email: email).first
          session[:current_user] = user
          render json: {
            access_token: command.result,
            message: 'Login Realizado, se estiver no browser acesse api/quotes/{palavra-chave}'
          }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
    end


end
