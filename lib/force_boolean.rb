module Mongoid
  module ForceBoolean
    extend ActiveSupport::Concern
    class NotMongoidDocumentError < StandardError; end

    included do
      raise NotMongoidDocumentError, "The #{self.name} class is not Mongoid::Document." unless ancestors.include?(Mongoid::Document)

      validate :force_boolean, if: :has_boolean_field?
    end

    def force_boolean
      self.class.boolean_fields.map do |field|
        if (field_value = self.read_attribute(field)) && field_value != true && field_value != false

          if field_value.to_s == '0'
            self.write_attribute(field, false)
          elsif field_value.to_s == '1'
            self.write_attribute(field, true)
          elsif !field_value.nil?
            self.errors.add(field, 'must be boolean')
          end
        end
      end

      self.errors.empty?
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
