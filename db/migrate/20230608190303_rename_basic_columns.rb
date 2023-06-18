class RenameBasicColumns < ActiveRecord::Migration[7.0]

  TABLE_COLUMNS_MAPPING = {
    apps_join_features: [:configurable_app_id, :app_id],
    apps: [:apartment_id, :society_id]
  }

  def up
    TABLE_COLUMNS_MAPPING.each do |table, columns|
      from_column = columns.first
      to_column = columns.second
      rename_column table, from_column, to_column if column_exists? table, from_column
    end
  end

  def down
    TABLE_COLUMNS_MAPPING.each do |table, columns|
      from_column = columns.second
      to_column = columns.first
      rename_column table, from_column, to_column if column_exists? table, from_column
    end
  end

end
