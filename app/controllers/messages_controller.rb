class MessagesController < ApplicationController
  before_action :require_login, only: [:index, :destroy]

  def index
    @messages = Message.where(user_id: current_user.id)
  end

  def destroy
    if Message.find(params[:id]).destroy
      flash[:success] = 'Message is deleted successfully.'
    else
      flash[:error] = 'Message failed to delete.'
    end
    redirect_to action: 'index'
  end
end
