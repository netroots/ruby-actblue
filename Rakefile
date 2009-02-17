require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

Version = '0.0.1'

Spec::Rake::SpecTask.new("spec") do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--color']
end
 
desc 'Generate RDoc documentation'
Rake::RDocTask.new(:rdoc) do |rdoc|
  files = ['README','lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main     = "README.textile" 
  rdoc.title    = "ruby-actblue"
  rdoc.rdoc_dir = 'doc' 
  rdoc.options << '--inline-source'
end