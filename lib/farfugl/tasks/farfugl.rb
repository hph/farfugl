require 'rake'

task default: :farfugl

desc 'Run migrations one by one, checked out to the correct environment'
task farfugl: :environment do
  Farfugl.migrate
end
