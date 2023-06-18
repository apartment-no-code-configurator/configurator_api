require_relative './../../crud_operations_helpers/base_internal_service_helper.rb'
require_relative './../../crud_operations_helpers/join_internal_service_helper.rb'

module InternalCrudServices

  module InternalCrudLibs

    module Features

      class FeatureObj

        include InternalCrudServices::CrudOperationsHelpers

        @@base_internal_service_helper = BaseInternalServiceHelper.new(Feature)

        attr_accessor :params, :join_internal_service_helper, :parent_record, :record
        def initialize(params={})
          @params = params
          @record = params[:id].present? ? get_object : Feature.new(params)
        end

        def create
          ActiveRecord::Base.transaction {
            @record = base_internal_service_helper.create_record(params)
            join_internal_service_helper.join_to_parent
            self
          }
        end

        def update
          #TO-DO: Check from git clone from react and/or react-native repos (if applicable) if folder is present or not for is_published key
          #TO-DO: On publishing, need to send official notification to all tenants/societies regarding new feature being launched. If service is fully added to configurable app, then feature is added automatically, else we leave it to be manually added.
          @record = base_internal_service_helper.update(params, record_id)
          self
        end

        def delete
          base_internal_service_helper.delete(record_id)
        end

        def get_object
          base_internal_service_helper.get_object(record_id)
        end

        def self.get_list
          @@base_internal_service_helper.get_list
        end

        private

        def join_internal_service_helper
          @join_internal_service_helper || set_join_internal_service_helper
        end

        def set_join_internal_service_helper
          @join_internal_service_helper = JoinInternalServiceHelper.new(record, parent_record, "service") if record_id
          @join_internal_service_helper
        end

        def record_id
          record.id rescue params[:id]
        end

        def parent_record
          @parent_record = @parent_record || Service.find_by(id: params[:service_id])
          @parent_record
        end

        def base_internal_service_helper
          @@base_internal_service_helper
        end

      end

    end

  end

end
