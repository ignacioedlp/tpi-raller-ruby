ActiveAdmin.register OpeningHour do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :branch_office_id, :day, :opens, :closes
  #
  # or
  #
  permit_params do
    # Convert day to integer to save in database 
    permitted = [:branch_office_id, :day, :opens, :closes]
    permitted
  end

  index do
    selectable_column
    id_column
    column "Sucursal", :branch_office
    column "Dia", :days
    column "Abre", :opens
    column "Cierra", :closes
    column "Creacion", :created_at
    column "Actualizacion", :updated_at
    actions
  end

  show do
    attributes_table do
      row :branch_office
      row :day
      row :opens
      row :closes
      row :created_at
    end
  end

  # Custom update 
  controller do
    def update
      # Convert day to integer to save in database
      params[:opening_hour][:day] = params[:opening_hour][:day].to_i
      super
    end
    def create
      # Convert day to integer to save in database
      params[:opening_hour][:day] = params[:opening_hour][:day].to_i
      super
    end
  end


  filter :branch_office
  filter :day
  filter :opens
  filter :closes
  filter :created_at


  form do |f|
    f.inputs do
      f.input :branch_office, as: :select, collection: BranchOffice.all, label: "Sucursal"
      f.input :day, as: :select, collection: OpeningHour::DAYS, label: "Dia"
      f.input :opens, label: "Abre"
      f.input :closes, label: "Cierra"
    end
    f.actions
  end
  
end
