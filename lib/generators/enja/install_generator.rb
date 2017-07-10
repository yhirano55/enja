require "rails/generators/migration"
require "generators/enja/helper"

module Enja
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      include Enja::Generators::Helper

      source_root File.expand_path("../templates", __FILE__)

      class_option :model, optional: true,
                           type:     :string,
                           banner:   "model",
                           desc:     "Specify the model class name if you will use anything other than `User`",
                           default:  "User"

      class_option :attribute, optional: true,
                               type:     :string,
                               banner:   "attribute",
                               desc:     "Specify the attribute name if you will use anything other than `role`",
                               default:  "role"

      def prepare_resource_model
        generate "model", "#{model_class_name}" unless model_class_name.safe_constantize
      end

      def prepare_migration
        migration_template "migration.erb", "db/migrate/add_role_to_user_resources.rb", migration_class_name: migration_class_name
      end

      def inject_resource_model
        inject_into_file model_path, after: "class #{model_class_name} < ApplicationRecord\n" do
          "  define_role_field :#{attribute_name}, in: [:guest, :staff, :admin], default: :guest\n"
        end
      end
    end
  end
end
