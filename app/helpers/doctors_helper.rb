module DoctorsHelper

  def edit_link_for_ts(ts)
    form_tag "/admin/state/#{ts.id}", method: 'GET' do
      button_tag 'Edit', class: 'btn btn-default'
    end
  end

  def category_input
    collection_select :category, :category_id, all_cats, :id, :name, {}, class: 'form-control'
  end

end
