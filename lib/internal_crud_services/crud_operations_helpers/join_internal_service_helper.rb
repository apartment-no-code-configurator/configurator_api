module InternalCrudServices

  module CrudOperationsHelpers

    class JoinInternalServiceHelper

      attr_accessor :dependent_record, :parent_record, :association

      def initialize(dependent_record, parent_record, association)
        @dependent_record = dependent_record
        @parent_record = parent_record
        @association = association
      end

      def join_to_parent
        begin
          dependent_record.send("#{association}=", @parent_record)
          dependent_record.save!
        rescue => e
          raise_error(e)
        end
      end

      private

      def raise_error(e)
        raise e.message
      end

    end

  end

end
