module HomeHelper

  def nhs_number_form_field
    text_field_tag 'patient[email]', nil, class: "form-control", placeholder: 'Enter NHS Number'
  end

  def password_form_field
    password_field_tag 'patient[password]', nil, class: "form-control", placeholder: 'Enter Password'
  end


end
