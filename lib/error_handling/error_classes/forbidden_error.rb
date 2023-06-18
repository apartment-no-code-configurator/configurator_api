require_relative './base_api_error.rb'

module ErrorHandling
  module ErrorClasses
    class ForbiddenError < BaseApiError

      def status_code
        "403"
      end

      private

      def type
        "Forbidden"
      end

      def message
        "Access is not given to user"
      end

    end

  end
end
