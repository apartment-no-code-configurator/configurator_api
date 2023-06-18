class Feature < ApplicationRecord
  has_many :app_join_features
  has_many :apps, through: :app_join_features
  attribute :is_published, default: -> { false }

  belongs_to :service, class_name: "Service", foreign_key: "service_id"
end
