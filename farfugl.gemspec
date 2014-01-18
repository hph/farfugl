Gem::Specification.new do |s|
  s.name        = 'farfugl'
  s.version     = '0.0.1'
  s.date        = '2014-01-17'
  s.summary     = 'Run migrations one by one with the correct environment'
  s.description = 'Old migrations often require code that no longer exists. '\
                  'Farfugl will run your migrations one by one, checked out '\
                  'to the correct Git commit to make sure that they work.'
  s.authors     = ['Haukur Páll Hallvarðsson']
  s.email       = 'hph@hph.is'
  s.files       = Dir.glob('lib/**/*') + ['LICENSE',  'README.md']
  s.homepage    = 'https://github.com/hph/farfugl'
  s.license     = 'MIT'
end
