namespace :farfugl do
  desc 'Run migrations one by one, checked out to the correct environment'
  task migrate: :environment do
    Farfugl.migrate
  end
end
