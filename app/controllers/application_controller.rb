class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :signedin_page
  before_filter :monster_create_restriction
  before_filter :team_create_restriction

  def signedin_page
    if user_signed_in? && request.path == '/'
      redirect_to monsters_path
    end
  end

  def monster_create_restriction
    if user_signed_in? && request.path == new_monster_path && current_user.monsters.count >= 20
      redirect_to monsters_path
    end
  end

  def team_create_restriction
    if user_signed_in? && request.path == new_team_path && current_user.teams.count >= 3
      redirect_to monsters_path
    end
  end
end
