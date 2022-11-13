# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }



  content title: proc { I18n.t("active_admin.dashboard") } do
  
    @users = User.last(5)
  
      columns do
        column do
          panel "Ultimos 5 usuarios registrados" do
            table_for @users do
              column :email
              column :created_at
            end
          end
        end
      end
  end # content


  # Authorizar solo a los administradores del sistema, que tengan el rol de admin
  controller do
    before_action :authenticate_admin_user!
    before_action :authorize_admin
    def authorize_admin
      if current_admin_user.role != "admin"
        redirect_to root_path, alert: "No estas autorizado para ver esta pagina"
      end
    end
  end

  
end
