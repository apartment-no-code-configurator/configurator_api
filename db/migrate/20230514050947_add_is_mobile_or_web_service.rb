require_relative '../migration_utils.rb'

class AddIsMobileOrWebService < ActiveRecord::Migration[7.0]

  #1 -> both, 2 -> web, 3 -> mobile
  include MigrationUtils

  def up
    add_with_verification_column(:services, :is_mobile_or_web_or_both, "ENUM('0','1','2', '3') DEFAULT '0'")
  end

  def down
    remove_with_verification_column(:services, :is_mobile_or_web_or_both)
  end
end
