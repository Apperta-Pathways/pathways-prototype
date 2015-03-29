module AccessControlHelper

  def check_if_doctor
    if current_doctor and !current_doctor.superuser
      check_if_doctor_has_access_to_patient
    end
  end

  private

  def check_patient
    patient = Patient.find_by_id params[:id]
    doctor = current_doctor

    if(!doctor.patients.include?(patient))
      default_redirect
    end

  end

  def check_state
    state = TreatmentState.find_by_id params[:id]
    doctor = current_doctor

    if(state && !doctor.patients.include?(state.patient))
      default_redirect
    end

  end

  def check_if_doctor_has_access_to_patient
    if(params[:id] && (request.path == doctor_hub_path || request.path == edit_patient_path) )
      check_patient
    end

    if(params[:id] && (request.path == edit_treatment_state_path || request.path == edit_state_path))
      check_state
    end

  end

  def default_redirect
    flash[:error] = set_error_text
    redirect_to '/admin'
  end

  def set_error_text
    error = "You are unauthorized to access this page"
  end

end
