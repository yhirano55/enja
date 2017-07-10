module Enja
  class Railtie < Rails::Railtie
    initializer "enja" do
      ActiveSupport.on_load(:active_record) do
        include Enja
      end
    end
  end
end
