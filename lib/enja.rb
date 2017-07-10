require "enumerize"

require "enja/railtie"
require "enja/version"

module Enja
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def define_role_field(attribute_name = :role, options = {})
      enumerize_options = enja_default_options.merge!(options)

      extend ::Enumerize
      enumerize(attribute_name.to_sym, enumerize_options)
      enumerize_options[:in].each do |role|
        scope(role, -> { where(attribute_name => role) })
        define_method(:"#{role}!") { update!(attribute_name => role ) }
      end

      validates(attribute_name, presence: true)
    end

    private

    def enja_default_options
      {
        in:         %i(guest staff admin),
        default:    :guest,
        predicates: true,
        scope:      true,
      }
    end
  end
end
