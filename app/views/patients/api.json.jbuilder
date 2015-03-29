json.treatment_states @states do |state|
  json.assigned_date state.assigned_date

  json.data_modules state.data_modules do |dm|
    json.title dm.title
    json.data dm.data
  end

end
