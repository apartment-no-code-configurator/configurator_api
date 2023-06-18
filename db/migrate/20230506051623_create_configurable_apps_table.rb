require_relative '../migration_utils.rb'
class CreateConfigurableAppsTable < ActiveRecord::Migration[7.0]
  include MigrationUtils

  TABLE_NAME = :configurable_apps

  def up
    create_table TABLE_NAME do |t|
      t.string :name, :unique => true
      t.string :apple_store_details
      t.string :google_playstore_details
      t.string :web_url
      t.bigint :apartment_id
      t.timestamps
    end unless table_exists? TABLE_NAME

    add_foreign_key_column(TABLE_NAME, :apartments, :apartment_id)
  end

  def down
    delete_table TABLE_NAME
  end
end
