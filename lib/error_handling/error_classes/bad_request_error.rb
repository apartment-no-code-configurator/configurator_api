require_relative './base_api_error.rb'

module ErrorHandling
  module ErrorClasses
    class BadRequestError < BaseApiError

      def status_code
        "400"
      end

      private

      def type
        "Bad Request Error"
      end

    end
  end
end
