class AppJoinFeature < ApplicationRecord
  self.table_name = "apps_join_features"
  belongs_to :app, class_name: "App", foreign_key: "app_id"
  belongs_to :feature, class_name: "Feature", foreign_key: "feature_id"
end
