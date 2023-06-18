class AppJoinService < ApplicationRecord
  self.table_name = "apps_join_services"
  belongs_to :app, class_name: "App", foreign_key: "app_id"
  belongs_to :service, class_name: "Service", foreign_key: "service_id"
end
