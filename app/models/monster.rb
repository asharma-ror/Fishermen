class Monster < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  scope :has_no_team, -> { where('team_id IS NULL') }

end
