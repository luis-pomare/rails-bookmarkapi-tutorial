class HealthController < ApplicationController
  def index
    def index
      render json: { status: 'online' }, status: 200
    end
  end
end
