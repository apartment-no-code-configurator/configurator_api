require_relative './../../crud_operations_helpers/base_internal_service_helper.rb'

module InternalCrudServices

  module InternalCrudLibs

    module SpecialCdns

      class SpecialCdnObj

        include InternalCrudServices::CrudOperationsHelpers

        attr_accessor :params, :base_internal_service_helper, :record
        def initialize(params={}, record_id=nil)
          @params = params
          @record = params[:id] ? SpecialCdn.find_by(id: params[:id]) : SpecialCdn.new(params)
          @base_internal_service_helper = BaseInternalServiceHelper.new(SpecialCdn)
        end

        def create
          base_internal_service_helper.create_record(params)
        end

        def update
          base_internal_service_helper.update(params, record_id)
        end

        def delete
          base_internal_service_helper.delete(record_id)
        end

        def get_object
          base_internal_service_helper.get_object(record_id)
        end

        def get_list
          base_internal_service_helper.get_list
        end

        private

        def record_id
          record.id rescue nil
        end

      end

    end

  end

end
