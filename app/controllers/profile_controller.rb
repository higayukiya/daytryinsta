class ProfileController < ApplicationController
    before_action :authenticate_user!

    def show
        @user  = User.find(params[:id])
        @profile = Profile.find(params[:id])
        @timelines = @user.timelines
    end

    def edit
        @profile = current_user.prepare_profile
    end

    def update
        @profile = current_user.prepare_profile
        @profile.assign_attributes(profile_params)
        if @profile.save
            redirect_to profile_path, notice: 'プロフィール更新！'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def following
        #@userがフォローしているユーザー
        @user  = User.find(params[:id])
        @users = @user.following
        # render 'show_follow'
    end

    def followers
        #@userをフォローしているユーザー
        @user  = User.find(params[:id])
        @users = @user.followers
        # render 'show_follower'
    end

    
    private
    def profile_params
        params.require(:profile).permit(
        :avatar
        )
    end
end
