class Api::LikesController < Api::ApplicationController
    before_action :authenticate_user!


  def show
    timelines = Timeline.find(params[:timelines_id])
    like_status = current_user.has_liked?(timelines)

    render json: { hasLiked: like_status }
  end

  def create
    timelines = Timeline.find(params[:timelines_id])
    timelines.likes.create!(user_id: current_user.id)

    render json: { status: 'ok' }
  end

  def destroy
    timelines = Timeline.find(params[:timelines_id])
    like = timelines.likes.find_by!(user_id: current_user.id)
    like.destroy!

    render json: { status: 'ok' }
  end
end
