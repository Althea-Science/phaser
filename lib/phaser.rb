require "configuration"
require "phaser/version"

module Phaser
  extend Configuration

  define_setting :api_url, 'http://localhost:3000'
  define_setting :token
end

require 'phaser/base'
require 'phaser/phase'
require 'phaser/parameter'
require 'phaser/patient'
require 'phaser/attempt'
require 'phaser/chart'
require 'phaser/value'
