module CategoriesHelper
  def link_to_edit_category(category)
    "/categories/#{category.id}/edit"
  end

end
