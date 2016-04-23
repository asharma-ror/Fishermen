class TeamsController < ApplicationController
  before_filter :authenticate_user!, only: :new

  def new
    @team = Team.new
    @monsters = current_user.monsters.has_no_team
  end

  def create
    team = current_user.teams.create(team_params)
    Monster.where(id: params[:monsters]).update_all(team_id: team.id)
    redirect_to monsters_path
  end

  private
    def team_params
      params.require(:team).permit(:name, :user_id)
    end
end
