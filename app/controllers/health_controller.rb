# app/controllers/health_controller.rb
class HealthController < ApplicationController
  skip_before_action :verify_authenticity_token
  # Pule qualquer outro before_action que possa impedir o acesso
  if defined?(Devise)
    skip_before_action :authenticate_user!, raise: false
  end

  def check
    status = { status: "ok", timestamp: Time.current.iso8601 }

    # Verificar conexão com banco de dados
    begin
      ActiveRecord::Base.connection.execute("SELECT 1")
      status[:database] = "connected"
    rescue => e
      status[:database] = "error: #{e.message}"
      return render json: status, status: :service_unavailable
    end

    render json: status, status: :ok
  end
end
