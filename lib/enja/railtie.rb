module Enja
  class Railtie < Rails::Railtie
    initializer "enja" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Enja
      end
    end
  end
end
