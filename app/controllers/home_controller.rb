class HomeController < ApplicationController
    before_action :set_menu
   
     def index
     end
   
     def about
     end
   
     def test
       render :layout => false
     end
   
     private
     # Use callbacks to share common setup or constraints between actions.
     def set_menu
       if user_signed_in?
        @my_menus = Menu.includes(functions: [:permissions]).where(permissions: {user_id: current_user.id})
       else
        @my_menus = []
       end
      end
   end
   