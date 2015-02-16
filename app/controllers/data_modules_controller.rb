class DataModulesController < ApplicationController

  def new
    @data_module = DataModule.new
  end

end
