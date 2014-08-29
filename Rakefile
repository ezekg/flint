desc "Install dependencies with Bundler"
task :install do
    system "bundle install"
end

desc "Run test suite with Guard"
task :test, [:watch] do |t, args|
    if args[:watch]
        system "cd tests && bundle exec compass watch --time"
    else
        system "cd tests && bundle exec compass compile --time"
    end
end
