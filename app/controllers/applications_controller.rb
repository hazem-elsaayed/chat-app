class ApplicationsController < ApplicationController
  def create
    return render json: { success: false, message: 'wrong params' }, status: 400 if params[:name].blank?
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
    return render json: { success: false, message: 'application not found' }, status: 404 if application.blank?
    render json: { success: true, data: application }
  end

  def update
    application = Application.where(token: params[:token])
    return render json: { success: false, message: 'wrong params' }, status: 400 if params[:name].blank? or application.blank?
    if application.update(name: params[:name])
      render json: { success: true, message: "successfully updated" }
    else
      render json: { success: false, message: 'wrong params' }, status: 404
    end
  end
end
