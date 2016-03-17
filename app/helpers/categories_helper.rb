module CategoriesHelper
  def link_to_edit_category(category)
    "/categories/#{category.id}/edit"
  end

  def category_delete_button(id)
    link_to "Delete", category_path(id), method: :delete, :class => "btn btn-danger"
  end

  

end
