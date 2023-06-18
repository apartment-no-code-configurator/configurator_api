class Society < ApplicationRecord

  has_many :apps, class_name: "App", foreign_key: "society_id"

end
