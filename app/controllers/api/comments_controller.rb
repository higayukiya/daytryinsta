class Api::CommentsController < Api::ApplicationController

    def index
        @timelines = Timeline.find(params[:timeline_id])
        comment = @timeline.comments

        render json:comment
    end

    # def new
    #     @user = current_user
    #     timelines = Timeline.find(params[:timeline_id])
    #     comment = timelines.comments.build(comment_params)
    # end

    def create
        timeline = Timeline.find(params[:timeline_id])
        comment = timeline.comments.build(comment_params)
        comment.save!

        render json: comment
    end


    private
    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id, timeline_id: params[:timeline_id])
    end
end
