# frozen_string_literal: true

require 'singleton'

class TypeaheadService
  include Singleton
  SUGGESTION_NUMBER = ENV['SUGGESTION_NUMBER']

  def initialize
    @names = {}
  end

  def initial_data(names)
    @names = names.sort_by { |key, value| [-value, key] }.to_h.transform_keys(&:to_s)
    @trie = Prefix::Trie.load_from_array(@names.keys.map(&:downcase))
  end

  def search(prefix = nil)
    names = prefix ? @trie.starts_with(prefix.downcase) : top_rated_names
    return [] if names.blank?

    build_response(names, prefix)
  end

  def update(name)
    match = matching_names(name)
    raise Record::NotFound if match.blank?

    @names[match.keys.first] += 1

    response_hash(match.keys.first, @names[match.keys.first])
  end

  def top_rated_names
    @names.keys.map(&:downcase).slice(0...suggestion_number)
  end

  private

  def build_response(names, prefix)
    filtered_names = find_all_case_sensitive_matches(names)
    results = filtered_names.map { |name, times| response_hash(name, times) }
    promote_exact_match(results, prefix).slice(0...suggestion_number)
  end

  def promote_exact_match(results, prefix)
    return results.select { |result| result[:name].downcase === prefix.downcase } | results if prefix

    results
  end

  def matching_names(request_name)
    @names.select { |name, _times| request_name.downcase === name.downcase }
  end

  def find_all_case_sensitive_matches(names)
    @names.select { |name, _times| names.include? name.downcase }
  end

  def response_hash(name, times)
    { name: name, times: times }
  end

  def suggestion_number
    SUGGESTION_NUMBER.to_i
  end
end
