class RepliesController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!
  before_action :set_reply, only: [:edit, :update, :show, :destroy]
  before_action :set_discussion, only: [:create, :edit, :show, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :set_bug, only: [:show, :edit, :update]

  def create
    @reply = @discussion.replies.create(params[:reply].permit(:reply, :discussion_id))
    @reply.user_id = current_user.id

    respond_to do |format|
      if @reply.save
        format.html { redirect_to discussion_path(@discussion) }
        format.js
      else
        format.html { redirect_to discussion_path(@discussion), notice: "Reply did not save. Please try again."}
        format.js
      end
    end
  end

  def destroy
    @reply = @discussion.replies.find(params[:id])
    @reply.destroy
    redirect_to discussion_path(@discussion)
  end

  def edit
    @discussion = Discussion.find(params[:discussion_id])
    @reply = @discussion.replies.find(params[:id])
  end


  def show
  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:reply)
  end
end
