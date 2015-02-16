module TreatmentStatesHelper
  def url_for_category(category)
    "/admin/state/#{@state.id}/#{category.id}"
  end

  def class_for_category(category)
    return 'list-group-item active' if @active_cat and @active_cat.id == category.id
    return 'list-group-item'
  end

  def url_for_subcategory(sc)
    "/admin/state/#{@state.id}/#{@active_cat.id}/#{sc.id}"
  end

  def class_for_subcategory(sc)
    return 'list-group-item active' if @active_subcat and @active_subcat.id == sc.id
    return 'list-group-item'
  end

  def field_name(dm)
    "module[#{dm.id}]"
  end

  def display_category(category)
    link_to url_for_category(category), class: class_for_category(category) do
      category.name
    end
  end

end
