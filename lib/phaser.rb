require "phaser/version"

module Phaser
  define_setting :api_url, 'http://localhost:3000'
end

require 'phaser/base'
require 'phaser/phase'
require 'phaser/parameter'
require 'phaser/patient'
require 'phaser/attempt'
require 'phaser/chart'
require 'phaser/value'

