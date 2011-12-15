ActiveAdmin.register Scenario do
  
  menu :parent => "Game"
  
  filter :guid
  
  # t.string   "guid"
  # t.integer  "owner_id"
  # t.text     "data"
  # t.integer  "state"
  # t.datetime "created_at"
  # t.datetime "updated_at"
  # t.string   "name"
  index do
    id_column
    column :name
    column :guid
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
      row :guid
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
      f.input :guid, :input_html => { :disabled => true }
    end
    f.buttons
  end
  
end
