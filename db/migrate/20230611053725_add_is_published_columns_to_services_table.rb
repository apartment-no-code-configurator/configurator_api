require_relative './../migration_utils.rb'

class AddIsPublishedColumnsToServicesTable < ActiveRecord::Migration[7.0]

  include MigrationUtils

  TABLE_NAME = :services

  def up
    add_with_verification_column(TABLE_NAME, :is_web_published, :boolean)
    add_with_verification_column(TABLE_NAME, :is_app_published, :boolean)

    change_column_default TABLE_NAME, :is_web_published, false
    change_column_default TABLE_NAME, :is_app_published, false

  end

  def down
    remove_with_verification_column(TABLE_NAME, :is_web_published, :boolean)
    remove_with_verification_column(TABLE_NAME, :is_app_published, :boolean)
  end
end
