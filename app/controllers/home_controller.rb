class HomeController < ApplicationController
  include ApplicationHelper
#   before_action :permission

  def index
  end

  def about
  end

  def test
    render :layout => false
  end
end
