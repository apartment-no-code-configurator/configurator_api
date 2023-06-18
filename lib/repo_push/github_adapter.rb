require "fileutils"
require "yaml"
#ideally should be broken to two classes - one for API repo, one for MFE repo, this should be the base/abstract class

module RepoPush

  class GithubAdapter


    API = "api"
    private_constant :API

    REACT = "react"
    private_constant :REACT

    REACT_NATIVE = "react-native"
    private_constant :REACT_NATIVE

    REPO_TYPE_MAPPING = {
      API => :api_repo_name,
      REACT => :react_repo_name,
      REACT_NATIVE => :react_native_repo_name
    }.freeze
    private_constant :REPO_TYPE_MAPPING

    REACT_APP_INITIALISATION_COMMAND = "create-react-app"
    private_constant :REACT_APP_INITIALISATION_COMMAND

    REACT_NATIVE_APP_INITIALIZATION_COMMAND = "npx create-expo-app"
    private_constant :REACT_NATIVE_APP_INITIALIZATION_COMMAND

    attr_accessor :github_client, :params, :s3_adapter, :repo_name

    def initialize(params)
      binding.break
      @params = params
      github_client
    end

    def create_api_repository
      create_repository(API)
    end

    def create_mfe_repository(type)
      create_repository(type)
      binding.break
      initialize_react_repo(type)
      git_add_all_changes_commit_and_push("Initializing MFE App")
      binding.break
      cleanup_git_clone
    end

    private

    def initialize_react_repo(type)
      @repo_name = self.send(REPO_TYPE_MAPPING[type])
      workflow_yaml = finalize_workflow_yaml(repo_name)
      system ("cd ..\n #{mfe_repo_creation_command(type)} #{repo_name}\n cd #{repo_name}\n  git init\n git branch -M main\n git remote add origin https://github.com/#{GithubAdapter.org_name}/#{repo_name}\n git pull\ngit push -u origin main\n  mkdir .github \n cd .github\n mkdir workflows\n cd workflows\n echo #{workflow_yaml} >> ci.yaml\n git add .\n git commit -m 'Adding workflows'\n git push")
    end

    def repo_path
      "../#{repo_name}"
    end

    def mfe_repo_creation_command(mfe_type)
      mfe_type == REACT ? REACT_APP_INITIALISATION_COMMAND : REACT_NATIVE_APP_INITIALIZATION_COMMAND
    end

    def finalize_workflow_yaml(repo_name)
      data = YAML.load_file(Rails.root.join("lib", "repo_push", "ci_yaml_template.yml"))
      data["jobs"]["build"]["steps"][3]["with"]["name"] = "#{repo_name}-build"
      data["jobs"]["deploy"]["steps"][2]["working-directory"] = "#{repo_name}-build"
      data["jobs"]["deploy"]["steps"][3]["working-directory"] = "#{repo_name}-build"
      data.to_yaml
    end

    def mandatory_apps
      params[:mandatory_apps]
    end

    def features
      params[:features]
    end

    def mfe_components_root_path
      "src/components/"
    end

    def github_client
      @github_client = @github_client || Github.new(oauth_token: GithubAdapter.token)
    end

    def self.token
      "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" #TO-DO : Shift to DB with encryption and decryption
      #@@token = @@token || InfraSetting.find_by(key: "github_token")
      #@@token
    end

    def self.org_name
      "apartment-no-code-configurator" #TO-DO : Shift to DB with encryption and decryption
      #@@org_name = @@org_name || InfraSetting.find_by(key: "github_org_name")
      #@@org_name
    end

    def base_github_repo_name
      params[:github_repo_name]
    end

    def api_repo_name
      "#{base_github_repo_name}-api"
    end

    def react_repo_name
      "#{base_github_repo_name}-react-mfe"
    end

    def react_native_repo_name
      "#{base_github_repo_name}-react-native-mfe"
    end

    def create_repository(type)
      binding.break
      github_client.repos.create name: self.send(REPO_TYPE_MAPPING[type]), org: GithubAdapter.org_name rescue nil #TO-DO: Remove the rescue statement
    end

    def add_feature_components_commit
      clone_repo
      create_component_folder(feature)
      git_add_all_changes_commit_and_push("Adding feature")
      cleanup_git_clone
    end

    def add_mandatory_app_components_commit
      clone_repo
      create_component_folder(mandatory_app)
      git_add_all_changes_commit_and_push("Adding mandatory_app")
      cleanup_git_clone
    end

    def clone_repo
      repo = github.repos.get(owner: owner, repo: repo_name)
      system("cd ..\n git clone #{repo.clone_url}\n")
    end

    def feature
      params[:feature]
    end

    def mandatory_app
      params[:mandatory_app]
    end

    def create_component_folder(component)
      FileUtils.mkdir_p("#{repo_path}/src/components/#{component}") #TO-DO : While testing, check what the root directory is
    end

    def git_add_all_changes_commit_and_push(message)
      system("cd #{repo_path} \n git push -u origin main\n git add .\n git commit -m 'Automated commit - #{message}'\n git push") #TO-DO : While testing, check what the root directory is
    end

    def cleanup_git_clone
      FileUtils.remove_dir("#{repo_path}") #TO-DO : While testing, check what the root directory is
    end

  end

end
