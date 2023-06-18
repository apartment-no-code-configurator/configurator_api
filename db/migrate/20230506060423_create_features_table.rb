require_relative '../migration_utils.rb'
class CreateFeaturesTable < ActiveRecord::Migration[7.0]

  TABLE_NAME = :features

  include MigrationUtils
  def up
    create_table TABLE_NAME do |t|
      t.string :name
      t.bigint :service_id
      t.timestamps
    end unless table_exists? TABLE_NAME

    add_index_to_columns TABLE_NAME, [:name, :service_id], {unique: true, name: "#{TABLE_NAME}_name_service_id_unique_constraint"}
    add_foreign_key_column TABLE_NAME, :services, :service_id
  end

  def down
    delete_table TABLE_NAME
  end

end
