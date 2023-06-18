class RenameBasicTables < ActiveRecord::Migration[7.0]

  TABLE_NAME_MAPPING = {
    apartments: :societies,
    configurable_apps: :apps,
    service_cdn_hosting: :service_cdns,
  }

  def up
    TABLE_NAME_MAPPING.each do |from_table_name, to_table_name|
      rename_table(from_table_name, to_table_name) if table_exists?(from_table_name)
    end
  end

  def down
    TABLE_NAME_MAPPING.each do |to_table_name, from_table_name|
      rename_table(from_table_name, to_table_name) if table_exists?(from_table_name)
    end
  end

end
