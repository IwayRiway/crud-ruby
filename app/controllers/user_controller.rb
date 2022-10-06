class UserController < ApplicationController
    # before_action :set_postingan, only: %i[ detail edit update destroy ]
    # before_action :authenticate_user!
  
    def index
      @data = User.all
    end

    def manage
        @data = User.find(params[:id])
    end
  
  end
  