require 'serverspec'
require 'docker'

set :backend, :docker

set :docker_image, ENV['DOCKER_IMAGE']
set :docker_container, ENV['DOCKER_CONTAINER']

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'

# via. http://qiita.com/sue445/items/b67b0e7209a7fae1a52a
require "yaml"
require "itamae/node"

Dir["#{__dir__}/support/**/*.rb"].each { |f| require f }

def node
  return @node if @node

  hash = YAML.load_file("#{__dir__}/node.yml")

  @node = Itamae::Node.new(hash, Specinfra.backend)
end
