class <%= controller_class_name %>Controller < ApplicationController
  respond_to :html, :xml, :json

  expose(:<%= plural_table_name %>) { <%= orm_class.all(class_name) %> }
  expose(:<%= singular_table_name %>)

  def create
    <%= singular_table_name %>.save
    respond_with(<%= singular_table_name %>)
  end

  def update
    <%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
    respond_with(<%= singular_table_name %>)
  end

  def destroy
    <%= singular_table_name %>.destroy
    respond_with(<%= singular_table_name %>)
  end
end
