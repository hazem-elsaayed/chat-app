class ApplicationsController < ApplicationController
  def create
    application = Application.create(name: params[:name], chats_count: 0)
    msg = { success: true, token: application.token }
    render json: msg
  end

  def index
    applications = Application.select('name, token, chats_count').all
    render json: { success: true, data: applications }
  end

  def show
    application = Application.select('name, token, chats_count')
      .where(token: params[:token])
    if application.blank?
      render json: { success: false, message: "application not found" }, status: 404
    else  
      render json: { success: true, data: application }
    end
  end
end
