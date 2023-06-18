class App < ApplicationRecord

  has_many :app_join_features, class_name: "AppJoinFeature", foreign_key: "app_id"
  has_many :features, through: :app_join_features
  has_many :app_join_services, class_name: "AppJoinService", foreign_key: "app_id"
  has_many :services, through: :app_join_services

  belongs_to :society, class_name: "Society", foreign_key: "society_id"

end
