# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    characters_path(resource)
  end
end
