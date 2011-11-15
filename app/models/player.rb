# Player record associates a User with a Game and important
# data about that game
class Player < ActiveRecord::Base
  belongs_to :user
  # belongs_to :game
end
