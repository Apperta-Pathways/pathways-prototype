class DownloadController < ApplicationController
  before_action :authenticate_doctor!

  def log

  	file_path = "#{Rails.root}/log/development.log"

  	File.open(file_path, "r") do |f|
      send_data f.read, filename: "log_file.txt", type: "application/log"
    end

  end
end
