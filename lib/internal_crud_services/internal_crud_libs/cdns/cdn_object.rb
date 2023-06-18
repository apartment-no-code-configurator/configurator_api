require_relative './../../crud_operations_helpers/base_internal_service_helper.rb'
require_relative './../../crud_operations_helpers/join_internal_service_helper.rb'

module InternalCrudServices

  module InternalCrudLibs

    module Cdns

      class CdnObject

        include InternalCrudServices::CrudOperationsHelpers

        @@base_internal_service_helper = BaseInternalServiceHelper.new(ServiceCdns)

        attr_accessor :params, :join_internal_service_helper, :parent_record, :record
        def initialize(params={}, parent_record=nil)
          @params = params
          @record = params[:id].present? ? get_object : ServiceCdns.new(params)
          @parent_record = parent_record
        end

        def create
          @record = base_internal_service_helper.create_record(params)
          join_internal_service_helper.join_to_parent
          # TO-DO: create in AWS cloudfront, enable based on is_active value
          # TO-DO: update details in record
        end

        def enable
          if !record.is_active
            base_internal_service_helper.update({
              is_active: true
            }, record)
            # TO-DO: enable in AWS cloudfront
          end
        end

        def disable
          if record.is_active
            base_internal_service_helper.update({
              is_active: false
            }, record)
            # TO-DO: disable in AWS cloudfront
          end
        end

        def update
          @record = base_internal_service_helper.update(params, record_id)
        end

        # def delete
        #   base_internal_service_helper.delete(record_id)
        # end

        def get_object
          @record = base_internal_service_helper.get_object(record_id)
          record
        end

        def get_list
          base_internal_service_helper.get_list
        end

        private

        def record_id
          record.id rescue params[:id]
        end

        def join_internal_service_helper
          @join_internal_service_helper || set_join_internal_service_helper
        end

        def set_join_internal_service_helper
          @join_internal_service_helper = JoinInternalServiceHelper.new(record, parent_record.record, "service") if record_id
          @join_internal_service_helper
        end

        def base_internal_service_helper
          @@base_internal_service_helper
        end

      end

    end

  end

end
