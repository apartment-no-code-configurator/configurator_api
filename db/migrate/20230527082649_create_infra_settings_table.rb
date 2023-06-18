class CreateInfraSettingsTable < ActiveRecord::Migration[7.0]

  TABLE_NAME = :infra_settings

  def up
    create_table TABLE_NAME do |t|
      t.bigint :key
      t.bigint :parameter
      t.timestamps
    end unless table_exists? TABLE_NAME
  end

  def down
    drop_table TABLE_NAME
  end

end
