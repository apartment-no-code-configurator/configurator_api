module InternalCrudServices
  module CrudOperationsHelpers
    class BaseInternalServiceHelper

      attr_accessor :model

      def initialize(model)
        @model = model
      end

      def create_record(params)
        model.create!(params)
      end

      def update(params, record)
        record = model.find_by(id: record) unless record.instance_of?(model)
        raise_record_not_found if record.nil?
        record.update(params)
        record
      end

      def delete(record_id)
        model.destroy(model.find_by(id: record_id)) rescue raise_record_not_found
      end

      def get_object(record_id)
        object = model.find_by(id: record_id)
        raise_record_not_found if object.nil?
        object
      end

      def get_list
        model.all
      end

      private

      def raise_record_not_found
        raise "Record not found"
      end

    end
  end
end
