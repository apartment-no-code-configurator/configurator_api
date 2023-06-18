require_relative '../migration_utils.rb'
class AddUniquenessConstraintServicesName < ActiveRecord::Migration[7.0]

  include MigrationUtils

  TABLE_NAMES = [:services, :mandatory_apps]

  def up
    TABLE_NAMES.each { |table_name|
      add_index_to_columns table_name, [:name], {unique: true, name: "#{table_name}_name_unique_constraint"}
    }
  end

  def down
    TABLE_NAMES.each { |table_name|
      remove_index_with_verification(table_name, "#{table_name}_name_unique_constraint")
    }
  end

end
