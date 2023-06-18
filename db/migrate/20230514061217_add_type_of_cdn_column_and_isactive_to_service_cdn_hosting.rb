require_relative './../migration_utils.rb'

class AddTypeOfCdnColumnAndIsactiveToServiceCdnHosting < ActiveRecord::Migration[7.0]

  include MigrationUtils

  def up
    add_with_verification_column(:service_cdn_hosting, :type_of_cdn, "ENUM('Web','Mobile') DEFAULT 'Web'")
    add_with_verification_column(:service_cdn_hosting, :is_active, :boolean)
  end

  def down
    remove_with_verification_column(:service_cdn_hosting, :type_of_cdn)
    remove_with_verification_column(:service_cdn_hosting, :is_active)
  end
end
