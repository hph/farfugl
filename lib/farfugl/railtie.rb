module Farfugl
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'farfugl/tasks/farfugl.rake'
    end
  end
end
