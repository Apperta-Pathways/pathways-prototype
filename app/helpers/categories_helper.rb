module CategoriesHelper
  def link_to_edit_category(category)
    "/categories/#{category.id}/edit"
  end

  def category_delete_button(id)
    link_to "Delete", category_path(id), method: :delete, :class => "btn btn-danger"
  end

  def timeline_in_range(start_date, end_date)
    @timeline = (@patient.treatment_states.where("assigned_date >= ? AND
    assigned_date <= ?", start_date, end_date).sort_by &:assigned_date).reverse
  end


end
