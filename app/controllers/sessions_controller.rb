class SessionsController < ApplicationController
    skip_before_action :authenticate_request
    def new
        @session = User.new
    end
end