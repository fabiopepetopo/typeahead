# frozen_string_literal: true

module Prefix
  class Trie
    attr_accessor :results

    def initialize
      @root = Hash.new { |h1, key| h1[key] = {} }
    end

    def self.load_from_array(array)
      trie = Trie.new
      array.each { |word| trie.insert(word.to_s) }
      trie
    end

    def insert(word)
      current_node = @root
      word_array = word.chars << true
      word_array.each do |each_char|
        current_node[each_char] ||= Hash.new { |h1, key| h1[key] = {} }
        current_node = current_node[each_char]
      end
      word
    end

    def search(word)
      current_node = @root
      word.chars.each do |each_char|
        return false if current_node[each_char].nil?

        current_node = current_node[each_char]
      end

      current_node.keys.include?(true)
    end

    def starts_with(prefix)
      word = prefix
      current_node = @root
      word.chars.each do |each_char|
        return false if current_node[each_char].nil?

        current_node = current_node[each_char]
      end

      @results = []
      rebuild_word(word, current_node)
      @results
    end

    private

    def rebuild_word(word, base_node, partial = '')
      base_node.each_key do |pos|
        if pos == true
          @results << word + partial
        else
          rebuild_word(word, base_node[pos], partial + pos)
        end
      end
    end
  end
end
