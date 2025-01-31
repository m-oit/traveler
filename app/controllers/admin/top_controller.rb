class Admin::TopController < ApplicationController
  layout 'admin'
  
  def index
    render "admin/top"
  end
end
