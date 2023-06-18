require_relative '../migration_utils.rb'

class AddGithubRepoColumnToServicesTable < ActiveRecord::Migration[7.0]

  include MigrationUtils

  def up
    add_with_verification_column(:services, :github_repo_name, :string)
  end

  def down
    remove_with_verification_column(:services, :github_repo_name)
  end
end
