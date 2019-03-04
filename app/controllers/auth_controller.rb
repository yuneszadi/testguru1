class AuthController < ApplicationController
  before_action :set_request_page
  before_action :authenticate_user!
end
