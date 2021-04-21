class ProfileController < ApplicationController
    before_action :authenticate_user!

    def show
        @profile = current_user.profile
        @user = current_user
    end


    def create
    end
end
