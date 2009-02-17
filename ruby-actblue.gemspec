Gem::Specification.new do |s|
  s.name = "ruby-actblue"
  s.version = "0.0.2"
  s.date = "2009-02-17"
  s.summary = "Library for accessing the ActBlue API."
  s.email = "kyle.shank@gmail.com"
  s.homepage = "http://github.com/netroots/ruby-actblue"
  s.authors = ["Kyle Shank"]
  s.files = ['actblue4r.gemspec', 'lib/actblue.rb', 'lib/actblue/contribution.rb', 'lib/actblue/entity.rb', 'lib/actblue/instrument.rb', 'lib/actblue/line_item.rb', 'lib/actblue/page.rb', 'lib/actblue/source.rb', 'lib/actblue/candidacy.rb', 'lib/actblue/check.rb', 'lib/actblue/credit_card.rb', 'lib/actblue/election.rb', 'lib/actblue/expires.rb', 'lib/actblue/list_entry.rb', 'lib/actblue/office.rb', 'README']
  s.has_rdoc = false
  s.add_dependency("httparty", [">= 0.3.1"])
end