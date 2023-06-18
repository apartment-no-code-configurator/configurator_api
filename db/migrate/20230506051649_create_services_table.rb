require_relative '../migration_utils.rb'
class CreateServicesTable < ActiveRecord::Migration[7.0]
  include MigrationUtils

  TABLE_NAME = :services

  def up
    create_table TABLE_NAME do |t|
      t.string :name, :unique => true
      t.timestamps
    end unless table_exists? TABLE_NAME
  end

  def down
    delete_table TABLE_NAME
  end
end
