class ApplicationsController < ApplicationController
  def create
    application = Application.create(name: params[:name], chats_count: 0)
    msg = {success: true, token: application.token}
    puts msg
    render json: msg
  end
end
