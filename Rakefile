desc "Run test suite"
task :test, [:watch] do |t, args|
    if args[:watch]
        system "cd tests && bundle exec compass watch --time"
    else
        system "cd tests && bundle exec compass compile --time"
    end
end
