config_path = File.dirname(__FILE__) + '/../..'
config_file = "#{config_path}/config.txt"

Watirmark::Configuration.instance.defaults = {
  :configfile => config_file
}
#puts "Using config: #{Watirmark::Configuration.instance.inspect}"

def config
  Watirmark::Configuration.instance
end