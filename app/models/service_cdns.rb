class ServiceCdns < ApplicationRecord
  belongs_to :service, class_name: "Service", foreign_key: "service_id"
end
