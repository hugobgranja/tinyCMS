class Admin::AdminController < ApplicationController
  before_action :require_user

  layout 'admin'
end