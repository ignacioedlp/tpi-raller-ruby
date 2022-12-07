# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.title.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    @users = User.last(5)

    columns do
      column do
        panel "Turnos sucursales" do
          table_for BranchOffice.all.decorate do
            column "Surcusal", :name
            column "Turnos completados", :shifts_completed
            column "Turnos pendientes", :shifts_pending
          end
        end
        panel "Ultimos 5 usuarios registrados" do
          table_for @users do
            column :email
            column :created_at
          end
        end
      end
    end
  end # content
end
