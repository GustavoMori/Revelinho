# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :auth!

  private

  def auth!
    return if request.headers['Authentication-Token'] == ENV['AUTHENTICATION_TOKEN']

    head :unauthorized
  end
end
