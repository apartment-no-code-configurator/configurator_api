class MandatoryApp < ApplicationRecord
  belongs_to :service, class_name: "Service", foreign_key: "service_id"
  attribute :is_published, default: -> { false }
end
