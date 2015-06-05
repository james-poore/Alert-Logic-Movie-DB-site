require 'rubygems'
gem 'daemons'
require 'daemons'

ENV['BUNDLE_GEMFILE'] ||= File.join(Dir.pwd, 'Gemfile')

pwd  = File.dirname(File.expand_path(__FILE__))
file = pwd + '/site.rb'


Daemons.run_proc(
   'site', # name of daemon
   :log_output => true
 ) do
   exec "ruby #{file}"
end
