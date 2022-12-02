ActiveAdmin.register BranchOffice do
  menu label: proc { I18n.t("active_admin.title.branch_offices") }
  decorate_with BranchOfficeDecorator
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name,
    :address,
    :phone
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :phone]
  #   permitted << :other if params[:action] == 'create' && current_user.has_role?(:admin)
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :phone
    column :shifts
    actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :phone
      row :created_at
    end

    # Mostrar un panel con los horarios por dia de Lunes a Domingo
    panel "Horarios de atencion" do
      attributes_table_for branch_office.opening_hours.decorate do
        row :name
        row :opens
        row :closes
      end
    end
  end

  filter :name

  controller do
    def create
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para crear sucursales"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para editar sucursales"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_branch_offices_path, alert: "No tiene permisos para eliminar sucursales"
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :phone
    end

    f.actions
  end
end
