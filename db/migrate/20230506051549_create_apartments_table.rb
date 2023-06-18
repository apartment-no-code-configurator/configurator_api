require_relative '../migration_utils.rb'
class CreateApartmentsTable < ActiveRecord::Migration[7.0]

  include MigrationUtils

  TABLE_NAME = :apartments

  def up
    p TABLE_NAME
    create_table TABLE_NAME do |t|
      t.string :name
      t.string :property_identification_number
      t.string :logo_s3_path
      t.timestamps
    end unless table_exists? TABLE_NAME
  end

  def down
    delete_table TABLE_NAME
  end

end
