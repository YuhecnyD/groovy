class Exchange < ApplicationRecord
  belongs_to :user
  belongs_to :requested_vinyl, class_name: "UsersVinyl", foreign_key: :requested_vinyl_id
  has_many :offered_vinyls
  # belongs_to :offered_vinyl, class_name: "CollectionVinyl", foreign_key: :offered_vinyl_id, optional: true
  # has_many :collections_vinyls, through: :offered_vinyls
  # has_many :vinyls, through: :collections_vinyls
  enum status: {
    pending: 0,
    Confirmed: 1,
    Rejected: 2

  }
  validates :requested_vinyl, presence: true
end
