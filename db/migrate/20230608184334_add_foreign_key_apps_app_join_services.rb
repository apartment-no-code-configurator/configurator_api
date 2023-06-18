require_relative './../migration_utils.rb'

class AddForeignKeyAppsAppJoinServices < ActiveRecord::Migration[7.0]

  include MigrationUtils

  def up
    add_foreign_key_column(:apps_join_services, :apps, :app_id)
  end

  def down
    add_foreign_key_column(:apps_join_services, :apps, :app_id) if foreign_key_exists?(:app_join_services, column: :service_id)
  end

end
