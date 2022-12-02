ActiveAdmin.register User do
  menu label: proc { I18n.t("active_admin.title.users") }
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :username, :password, :password_confirmation
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :username
      row :created_at
    end
  end

  filter :email
  filter :username

  controller do
    def create
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_users_path, alert: "No tiene permisos para crear usuarios"
      end
    end

    def update
      if current_admin_user.has_role? :admin
        # Si no se introduce una contraseña, se mantiene la actual
        if params[:user][:password].blank?
          params[:user].delete("password")
        end
        super
      else
        redirect_to admin_users_path, alert: "No tiene permisos para editar usuarios"
      end
    end

    def destroy
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_users_path, alert: "No tiene permisos para eliminar usuarios"
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      # Set optional password fields only if the user is being created
      f.input :password, required: f.object.new_record?
      if f.object.new_record?
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
