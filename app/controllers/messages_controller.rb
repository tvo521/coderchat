class MessagesController < ApplicationController
  before_action :require_login, only: [:index, :destroy, :new, :create]

  def index
    @messages = Message.where(user_id: current_user.id).order(created_at: :desc)
  end

  def destroy
    if Message.find(params[:id]).destroy
      flash[:success] = 'Message is deleted successfully.'
    else
      flash[:error] = 'Message failed to delete.'
    end
    redirect_to action: 'index'
  end

  def new
    @message = Message.new
    @message.sender = current_user.email
    @message.user = User.find(params[:user_id])
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = "Message has been sent to #{@message.user.email}"
      redirect_to action: 'index'
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id, :sender)
  end
end
