class RenamePropertyIdentificationIdToAoaNumber < ActiveRecord::Migration[7.0]
  def up
    if column_exists? :societies, :property_identification_number
      rename_column :societies, :property_identification_number, :aoa_number
      add_index :societies, :aoa_number, unique: true
    end
  end

  def down
    rename_column :societies, :property_identification_number, :aoa_number if column_exists? :societies, :property_identification_number
  end
end
