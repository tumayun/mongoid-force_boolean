module Mongoid
  module ForceBoolean
    extend ActiveSupport::Concern
    class NotMongoidDocumentError < StandardError; end

    included do
      raise NotMongoidDocumentError, "The #{self.name} class  is not Mongoid::Document." unless ancestors.include?(Mongoid::Document)

      before_save :force_boolean!, if: :has_boolean_field?
    end

    def force_boolean!
      self.class.boolean_fields.map do |field|
        if (field_value = self.read_attribute(field)) && field_value != true && field_value != false

          if field_value.to_s == '0'
            self.write_attribute(field, false)
          elsif field_value.to_s == '1'
            self.write_attribute(field, true)
          else
            raise TypeError, "The #{field} field is not boolean type."
          end
        end
      end
    end

    def has_boolean_field?
      self.class.has_boolean_field?
    end

    module ClassMethods

      def boolean_fields
        return @boolean_fields if defined?(@boolean_fields)
        @boolean_fields = fields.select { |_, field| field.type == ::Boolean }.keys
      end

      def has_boolean_field?
        !boolean_fields.empty?
      end
    end
  end
end
