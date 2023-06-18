require_relative './../migration_utils.rb'

class CreateMandatoryAppsJoinApartmentsTable < ActiveRecord::Migration[7.0]

  include MigrationUtils

  TABLE_NAME = :mandatory_apps_join_apartments
  def up
    create_table TABLE_NAME do |t|
      t.bigint :apartment_id
      t.bigint :mandatory_app_id
      t.timestamps
    end unless table_exists? TABLE_NAME

    add_foreign_key_column(TABLE_NAME, :mandatory_apps, :mandatory_app_id)
    add_foreign_key_column(TABLE_NAME, :apartments, :apartment_id)

  end

  def down
    drop_table TABLE_NAME
  end

end
