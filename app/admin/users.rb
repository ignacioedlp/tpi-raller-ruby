ActiveAdmin.register User do

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
    column "Email", :email
    column "Username", :username
    column "Creacion", :created_at
    column "Actualizacion", :updated_at
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
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email, label: "Email"
      f.input :username, label: "Username"
      if f.object.new_record? 
        f.input :password, label: "Contraseña"
        f.input :password_confirmation, label: "Confirmar contraseña"
      end
    end
    f.actions
  end

end
