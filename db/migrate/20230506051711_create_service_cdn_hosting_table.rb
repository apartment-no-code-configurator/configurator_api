require_relative '../migration_utils.rb'
class CreateServiceCdnHostingTable < ActiveRecord::Migration[7.0]
  include MigrationUtils

  TABLE_NAME = :service_cdn_hosting

  def up
    create_table TABLE_NAME do |t|
      t.string :name, :unique => true
      t.string :cdn_hosting_details
      t.bigint :service_id
      t.timestamps
    end unless table_exists? TABLE_NAME

    add_foreign_key_column(TABLE_NAME, :services, :service_id)

  end

  def down
    delete_table TABLE_NAME
  end
end
