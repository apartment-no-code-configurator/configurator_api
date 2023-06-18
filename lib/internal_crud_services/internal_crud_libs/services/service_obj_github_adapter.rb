require_relative "./../../../repo_push/github_adapter.rb"

module InternalCrudServices
  module InternalCrudLibs
    module Services

      include RepoPush

      class ServiceObjGithubAdapter < GithubAdapter

        def create_api_and_mfe_repositories
          binding.break
          create_api_repository
          create_mfe_repository("react")
          create_mfe_repository("react native")
        end

      end

    end
  end
end
