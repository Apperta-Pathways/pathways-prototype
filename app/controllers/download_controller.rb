class DownloadController < ApplicationController
  before_action :grant_access, only: [:log]

  def log

  	file_path = "#{Rails.root}/log/production.log"

  	File.open(file_path, "r") do |f|
      send_data f.read, filename: "log_file.txt", type: "application/log"
    end

  end

  private

  	def grant_access
  		if(current_doctor)
  			assert_superuser
  		else
  			flash[:error] = 'You do not have permission to access this page'
  			redirect_to categories_path
  		end
  	end
end
