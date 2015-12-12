class Message < ActiveRecord::Base
  belongs_to :user

  validates :body, :sender, presence: true
end
