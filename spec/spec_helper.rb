$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'mongoid'
require 'active_support' unless defined?(ActiveSupport)
require 'force_boolean'
