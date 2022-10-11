class UserController < ApplicationController
    include ApplicationHelper
    before_action :permission, except: [:create, :update, :show]
    before_action :authenticate_user!
    # before_action :set_postingan, only: %i[ detail edit update destroy ]
  
    def index
      @data = User.all
    end

    def manage
        @data = User.find(params[:id])
        @menu = Menu.all()
    end

    def create
      data = []
      ceklis = params[:ceklis]
      user = params[:user_id]

      for value in ceklis do
        array = {user_id: user, function_id: value}
        data.push(array)
      end

      Permission.where(:user_id => user).destroy_all

      Permission.insert_all(data)
      flash[:success] = "Data Berhasil Disimpan.."
      redirect_to('/user/index')
    end
  
  end
  