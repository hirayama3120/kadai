module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :do_inactive]

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
        response_bad_request
      else
        if User.exists?(FirstName: @user.FirstName,LastName: @user.LastName,MailAddress: @user.MailAddress)
          response_conflict(:user)
        else
          if @user.save
            response_success(:user, :create)
          else
            response_internal_server_error
          end
        end
      end
    end

    # PATCH/PUT /api/users/:id
    def update
      if @user.update(user_params)
        response_success(:user, :update)
      else
        response_internal_server_error
      end
    end

    # DELETE /api/users/:id
#    def do_inactive
#      #if @user.do_inactive(@delete_user, DeleteFlag: 1)
#      if @user.do_inactive(@delete_user, DeleteFlag: 1)
#        render json: @user
#      else
#        render json: @user.errors, status: :unprocessable_entity
#      end
#    end
    def do_inactive
      if @user.do_inactive
        response_success(:user, :update)
      else
        response_internal_server_error
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find_by(params[:id])
        
        response_not_found(:user) if @user.blank?
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.fetch(:user, {}).permit(:FirstName, :LastName, :Age, :MailAddress)
      end

#      # Only allow a trusted parameter "white list" through.
#      def set_delete_user
#        @delete_user = params[:id]
#      end

  end
end