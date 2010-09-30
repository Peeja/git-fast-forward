begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "git-fast-forward"
    gemspec.summary = "Git command that works like merge, but never creates a merge commit."
    gemspec.description = gemspec.summary
    gemspec.email = "peter.a.jaros@gmail.com"
    gemspec.homepage = "http://github.com/Peeja/git-fast-forward"
    gemspec.authors = ["Peter Jaros"]
    gemspec.files = FileList['bin/*'] + FileList['lib/**/*.rb']
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
