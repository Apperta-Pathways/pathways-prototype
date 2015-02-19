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
    content_tag 'select', class: 'form-control' do
      content_tag_for :option, @categories do |c|
        c.name
      end
    end
  end

  def subcategory_input
    content_tag 'select', class: 'form-control' do
      content_tag_for :option, @subcategories do |sc|
        sc.name
      end
    end
  end

  def title_input
    text_field_tag 'name', nil, placeholder: 'Enter information module title', class: 'form-control'
  end
end
