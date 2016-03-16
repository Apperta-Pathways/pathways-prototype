module SubcategoriesHelper
  def subcategory_delete_button(id)
    link_to "Delete", subcategory_path(id), method: :delete, :class => "btn btn-danger"
  end

  def data_module_delete_button(id)
    link_to "Delete", data_module_path(id), :method => 'delete', class: 'btn btn-danger'
  end

  def data_module_edit_button(id)
    link_to "Edit", edit_data_module_path(id), class: 'btn-default btn'
  end

  def data_module_preview_button(id)
    link_to "Preview", data_module_path(id), class: 'btn btn-default'
  end
end
