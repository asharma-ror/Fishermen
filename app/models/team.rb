class Team < ActiveRecord::Base
  has_many :monsters
  belongs_to :user
end
