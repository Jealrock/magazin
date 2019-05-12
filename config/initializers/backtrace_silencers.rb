# Be sure to restart your server when you modify this file.

# You can add backtrace silencers for libraries that you're using but don't wish to see in your backtraces.
# Rails.backtrace_cleaner.add_silencer { |line| line =~ /my_noisy_library/ }

# You can also remove all the silencers if you're trying to debug a problem that might stem from framework code.
# Rails.backtrace_cleaner.remove_silencers!
Rails.application.config.content_security_policy do |policy|
  if Rails.env.development?
    policy.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035'
    policy.script_src :self, :https, :unsafe_eval
  else
    policy.script_src :self, :https
  end
end
