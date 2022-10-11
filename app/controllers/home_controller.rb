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
        sql = "SELECT 
                    a.* 
                FROM 
                    menus a 
                    JOIN functions b ON a.id = b.menu_id 
                    JOIN permissions c ON b.id = c.function_id 
                WHERE 
                    c.user_id = #{current_user.id} 
                GROUP BY 
                    a.name 
                ORDER BY 
                    id asc"
        @my_menus = ActiveRecord::Base.connection.execute(sql)
    else
        @my_menus = []
    end
   end
end
