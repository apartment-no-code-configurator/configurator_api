module ErrorHandling
  module ErrorClasses

    class UnprocessibleEntityError < BaseApiError

      def status_code
        "422"
      end

      private

      def type
        "Unprocessible Entity"
      end

    end

  end
end
