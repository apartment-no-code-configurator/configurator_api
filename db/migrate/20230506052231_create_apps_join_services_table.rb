require_relative '../migration_utils.rb'
class CreateAppsJoinServicesTable < ActiveRecord::Migration[7.0]

  TABLE_NAME = :apps_join_services
  #link services with only configurable apps app table records

  include MigrationUtils
  def up
    create_table TABLE_NAME do |t|
      t.bigint :configurable_app_id
      t.bigint :service_id
      t.timestamps
    end unless table_exists? TABLE_NAME

    add_foreign_key_column(TABLE_NAME, :configurable_apps, :configurable_app_id)
    add_foreign_key_column(TABLE_NAME, :services, :service_id)

  end

  def down
    delete_table TABLE_NAME
  end
end
