module Farfugl
  class Railtie < Rails::Railtie
    require_relative './tasks/farfugl.rb'
  end
end
