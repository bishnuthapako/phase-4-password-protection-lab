class UsersController < ApplicationController
    before_action :authorize, only:[:show]

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id]=user.id
            render json: user, status: :unprocessable_entity
        else
            render json: {error: user.errors.full_message}, status: :unprocessable_entity
        end
    end


    def show
        user = User.find_by(id: session[:user_id])
        render json: user
    end


    private

    def authorize
        # return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end

    def user_params
        # params.permit(:username, :password, :password_confirmation)
        params.permit(:username, :password, :password_confirmation)
    end
end
