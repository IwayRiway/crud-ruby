module ApplicationHelper
    include Pagy::Frontend
    
    def link_to_add_row(name, f, association, **args)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize, f: builder)
        end
        link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
    end

    def link_to_add_product_receiving_item(name, f, association, **args)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize, f: builder)
        end
        link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
    end

    def permission()
        current_uri = request.env['PATH_INFO']
        path = Rails.application.routes.recognize_path(current_uri)
        controller = path[:controller]
        action = path[:action]

        if action == 'show' && request.method.to_s == 'POST'
            action = "destroy"
        end

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
        # abort @my_menus.inspect
 
        cek = User.joins(:permissions => [{:function => :menu }]).where('functions.action' => action, "menus.controller" => controller).find_by(id: current_user.id)
        if cek == nil && action != "test" && action != "show" #cek apakah disini ada akses atau tidak
            redirect_to('/home/test')
        end
    end
end
