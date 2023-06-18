require_relative "./../migration_utils.rb"

class AddIsPublishedToFeaturesAndMandatoryApps < ActiveRecord::Migration[7.0]

  TABLE_NAMES = [:features, :mandatory_apps]
  DATATYPE = :boolean
  COLUMN = :is_published

  include MigrationUtils

  def up
    TABLE_NAMES.each { |table_name|
      add_with_verification_column(table_name, COLUMN, DATATYPE)
    }
  end

  def down
    TABLE_NAMES.each { |table_name|
      remove_with_verification_column(table_name, COLUMN)
    }
  end

end
