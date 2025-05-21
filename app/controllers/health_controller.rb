# app/controllers/health_controller.rb
class HealthController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!, if: -> { defined?(authenticate_user!) }

  def check
    render plain: "OK", status: 200
  end
end
