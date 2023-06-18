require_relative './base_api_error.rb'

module ErrorHandling
  module ErrorClasses
    class AuthenticationError < BaseApiError

      def status_code
        "401"
      end

      private

      def type
        "Unauthenticated"
      end

      def message
        "User is not authenticated"
      end

    end
  end
end
