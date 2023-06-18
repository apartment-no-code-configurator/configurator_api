class Service < ApplicationRecord
  has_many :service_cdns
  has_many :mandatory_apps
  has_many :apps_join_services
  has_many :apps, through: :app_join_services
end
