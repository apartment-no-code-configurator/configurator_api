module ErrorHandling
  module ErrorClasses
    class BaseApiError < StandardError
      def response_body
        {
          errors: {
            type: ,
            detail: message
          }
        }
      end
    end
  end
end
