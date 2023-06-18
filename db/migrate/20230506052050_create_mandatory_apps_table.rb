require_relative '../migration_utils.rb'
class CreateMandatoryAppsTable < ActiveRecord::Migration[7.0]
  include MigrationUtils

  TABLE_NAME = :mandatory_apps

  def up
    create_table TABLE_NAME do |t|
      t.string :name
      t.bigint :service_id
      t.boolean :is_public
      t.timestamps
    end unless table_exists? TABLE_NAME

    add_foreign_key_column TABLE_NAME, :services, :service_id

  end

  def down
    delete_table TABLE_NAME
  end
end
