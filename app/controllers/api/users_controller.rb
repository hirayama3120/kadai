module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :nullify]

    # GET /api/users
    def index
      @users = User.all

      render json: @users
    end

    # GET /api/users/1
    def show
      render json: @user
    end

    # POST /api/users
    def create
      @user = User.new(user_params)
      if @user.FirstName.blank? || @user.LastName.blank? || @user.Age.blank? || @user.MailAddress.blank? 
        render json: @user.errors, status: :bad_request
      else
        if User.exists?(FirstName: @user.FirstName,LastName: @user.LastName,MailAddress: @user.MailAddress)
          render json: @user.errors, status: :conflict
        else
          if @user.save
            #render json: @user, status: :created, location: @user
            render json: @user, status: :created, location: api_users_url(@user)
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end
      end
    end

    # PATCH/PUT /api/users/:id
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/users/:id
    def nullify
      if @user.nullify(@user)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private

      def set_user
        begin
          @user = User.find params[:id]
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'User Not Found' }, status: :not_found
        end
      end

      def user_params
        params.fetch(:user, {}).permit(:FirstName, :LastName, :Age, :MailAddress)
      end

  end
end