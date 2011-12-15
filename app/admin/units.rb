ActiveAdmin.register Unit do
  
  menu :parent => "Game"
  
  filter :group
  filter :guid
  filter :name
  filter :uclass
  filter :utype
  filter :status
  
  scope :all, :default => true
  scope :sunk
  scope :available
  scope :crippled
  scope :scuttled
  scope :in_pipeline

  index do
    id_column
    column :guid
    column :name
    column "Class", :uclass
    column :number
    column "Type", :utype
    default_actions
  end
  
end
