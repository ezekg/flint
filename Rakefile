desc "Run test suite"
task :test, [:watch] do |t, args|
  if args[:watch]
    system "cd tests && bundle exec compass watch --time"
  else
    system "cd tests && bundle exec compass compile --time"
  end
end

desc "Clear cache"
task :clean do
  system "cd tests && bundle exec compass clean"
end

desc "Output test status"
task :status do
  output = File.read "tests/output/output.css"
  results = /Test\sResults\s{(.*?)}/m.match output
  failed = /Failed:\s(\d+)/m.match results[0]

  if failed[0].to_i > 0
    puts "Tests failed"
    exit 1
  else
    puts "Tests passed"
    exit 0
  end
end

task :default => [:clean, :test, :status]
