require_relative './../../crud_operations_helpers/base_internal_service_helper.rb'
require_relative './../cdns/cdn_object.rb'
require_relative './service_obj_github_adapter.rb'
require_relative './../../../infra_adapters/s3_adapter.rb'


#TO-DO: Make creation of repo for MFEs dynamic as per CRUD - much later
#TO-DO: Make S3 folders creation of repo for MFEs dynamic - much later
module InternalCrudServices

  module InternalCrudLibs

    module Services

      class ServiceObj

        include InternalCrudServices::CrudOperationsHelpers
        include InternalCrudServices::InternalCrudLibs::Cdns
        include InfraAdapters

        CDN_CREATION_ENUM_MAPPING = {
          0 => [false, false], # 0 -> neither
          1 => [true, true], # 1 -> both
          2 => [true, false], # 2 -> web enabled, mobile disabled
          3 => [false, true] # 3 -> web disabled, mobile enabled
        }.freeze
        private_constant :CDN_CREATION_ENUM_MAPPING

        @@base_internal_service_helper = BaseInternalServiceHelper.new(Service)

        attr_accessor :params, :record, :mobile_cdn, :web_cdn
        def initialize(params={})
          @params = params
          @record = params[:id].present? ? get_object : Service.new(params)
        end

        def create
          ActiveRecord::Base.transaction do
            base_repo_name = derive_repo_name(record.name)

            #db record
            @record = base_internal_service_helper.create_record(params.merge!({
                github_repo_name: "#{base_repo_name}-api"
              }
            ))

            if params[:is_mobile_or_web_or_both].present?
              # create CDN records in db
              create_cdn_records(params[:is_mobile_or_web_or_both])
              #S3 folder for MFE repos
              S3Adapter.new({repo: base_repo_name}).create_repo_folders
            end

            #Adding repos in github
            # ServiceObjGithubAdapter.new({
            #   mandatory_apps: params[:mandatory_apps],
            #   features: params[:features],
            #   github_repo_name: base_repo_name
            # }).create_api_and_mfe_repositories

            # trigger to create CDNs

            self
          end
        end

        def update
          ActiveRecord::Base.transaction do
            enable_or_disable_and_soft_delete_cdn(params[:is_mobile_or_web_or_both]) if record.is_mobile_or_web_or_both != params[:is_mobile_or_web_or_both]
            @record = base_internal_service_helper.update(params, record_id)
          end
          record
        end

        def delete
          base_internal_service_helper.delete(record_id)
        end

        def self.get_list
          @@base_internal_service_helper.get_list
        end

        private

        def get_object
          @record = base_internal_service_helper.get_object(record_id)
          record
        end

        def record_id
          record.id rescue params[:id]
        end

        def derive_repo_name(service_name)
          service_name.downcase.split(/\W+/).join("-")
        end

        def react_native_repo_name
          "#{record.name}-react-native-mfe-ui"
        end

        def react_repo_name
          "#{record.name}-react-mfe-ui"
        end

        def create_cdn_records(is_mobile_or_web_or_both)
          create_web_cdn(CDN_CREATION_ENUM_MAPPING[is_mobile_or_web_or_both].first)
          create_mobile_cdn(CDN_CREATION_ENUM_MAPPING[is_mobile_or_web_or_both].second)
        end

        def create_mobile_cdn(is_active=true)
          @mobile_cdn = CdnObject.new({
            name: react_native_repo_name,
            cdn_hosting_details: "",
            type_of_cdn: "Mobile",
            is_active: ,
            service_id: record.id
          }, self)
          mobile_cdn.create
        end

        def create_web_cdn(is_active=true)
          @web_cdn = CdnObject.new({
            name: react_repo_name,
            cdn_hosting_details: "",
            type_of_cdn: "Web",
            is_active: ,
            service_id: record.id
          }, self)
          web_cdn.create
        end

        def enable_or_disable_and_soft_delete_cdn(new_is_mobile_or_web_or_both)
          existing_is_mobile_or_web_or_both = record.is_mobile_or_web_or_both
          if new_is_mobile_or_web_or_both == 0
            disable_mobile_cdn
            disable_web_cdn
          elsif new_is_mobile_or_web_or_both == 1
            enable_mobile_cdn
            enable_web_cdn
          elsif new_is_mobile_or_web_or_both == 2
            disable_mobile_cdn
            enable_web_cdn
          elsif new_is_mobile_or_web_or_both == 3
            enable_mobile_cdn
            disable_web_cdn
          end
        end

        def enable_web_cdn
          create_web_cdn if web_cdn.blank?
          web_cdn.enable
        end

        def enable_mobile_cdn
          create_mobile_cdn if mobile_cdn.blank?
          mobile_cdn.enable
        end

        def disable_web_cdn
          create_web_cdn if web_cdn.blank?
          web_cdn.disable
        end

        def disable_mobile_cdn
          create_mobile_cdn if mobile_cdn.blank?
          mobile_cdn.disable
        end

        def mobile_cdn
          @mobile_cdn = @mobile_cdn || derive_cdn_record("Mobile")
          @mobile_cdn
        end

        def web_cdn
          @web_cdn = @web_cdn || derive_cdn_record("Web")
          @web_cdn
        end

        def derive_cdn_record(type_of_cdn)
          CdnObject.new(ServiceCdns.where(service_id: record.id).where(type_of_cdn: ).first , self) rescue nil
        end

        def base_internal_service_helper
          @@base_internal_service_helper
        end

      end

    end

  end

end
