ActiveAdmin.register User do
  menu label: proc { I18n.t("active_admin.title.users") }

  permit_params :email, :username, :password, :password_confirmation

  actions :all, except: [:new]

  config.remove_action_item :destroy
  config.remove_action_item :edit
  config.remove_action_item :new

  action_item :edit, only: :show do
    link_to "Editar cliente", edit_admin_user_path if current_admin_user.has_role? :admin
  end

  action_item :destroy, only: :show do
    link_to "Eliminar cliente", admin_user_path, method: :delete, data: {confirm: "¿Está seguro que desea eliminar este cliente?"} if current_admin_user.has_role? :admin
  end

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :created_at
    column :updated_at
    actions defaults: false do |user|
      item "Ver", admin_user_path(user), class: "member_link"
      item "Editar", edit_admin_user_path(user), class: "member_link" if current_admin_user.has_role? :admin
      item "Eliminar", admin_user_path(user), method: :delete, data: {confirm: "¿Está seguro que desea eliminar este cliente?"}, class: "member_link" if current_admin_user.has_role? :admin
    end
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
    def new
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_users_path, alert: "No tiene permisos para crear usuarios"
      end
    end

    def create
      if current_admin_user.has_role? :admin
        super
      else
        redirect_to admin_users_path, alert: "No tiene permisos para crear usuarios"
      end
    end

    def update
      if current_admin_user.has_role? :admin
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
      f.input :password, required: f.object.new_record?
      if f.object.new_record?
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
