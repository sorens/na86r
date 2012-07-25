ActiveAdmin.register Scenario do
  
  menu :parent => "Game"
  
  filter :uuid
  
  index do
    id_column
    column :name
    column :uuid
    column :state
    column :owner
    column "Data", :data do |a|
      a.data.length unless a.data.nil?
    end
    default_actions
  end
  
  show :title => :name do |a|
    attributes_table do
      row :id
      row :uuid
      row :name
      row :data do |a|
        a.data.length unless a.nil? or a.data.nil?
      end
      row :state
    end
  end
  
  form do |f|
    f.inputs "Scenario" do
      f.input :name
      f.input :owner_id
      f.input :data
      f.input :state
      f.input :uuid, :input_html => { :disabled => true }
    end
    f.buttons
  end
  
end
