module Api
  module V1
    class MonstersController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        respond_with Monster.all
      end

      def show
        monstor =  Monster.find(params[:id])
        render(json: monstor)
      end

      def create
        respond_with Monster.create(monster_params)
      end

      def update
        respond_with Monster.update(params[:id], params[:monsters])
      end

      def destroy
        respond_with Monster.destroy(params[:id])
      end

      private
      def monster_params
        params.require(:monster).permit(:name, :type, :power, :user_id, :team_id)
      end
    end
  end
end