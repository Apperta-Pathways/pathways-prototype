module DataModulesHelper

  def each_as_option(iters)
    iters.each do |c|
      content_tag 'option', c.name
    end
  end

  def each_category_as_option
    @categories.each do |c|
      content_tag 'option', c.name
    end
  end

  def category_input
    f.collection_select :category_id, @categories, :id, :name, {}, class: 'form-control'
  end

  def subcategory_input(f)
    f.collection_select :subcategory_id, @category.subcategories, :id, :name, {}, class: 'form-control'
  end

  def title_input(f)
    f.text_field :title, placeholder: 'Enter information module title', class: 'form-control'
  end
end
