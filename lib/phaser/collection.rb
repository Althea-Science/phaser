module Phaser

  class Collection
    include Enumerable

    attr_reader :set

    def initialize(set)
      @set = set
    end

    def each
      set.map { |item| yield item }
    end

  end

end