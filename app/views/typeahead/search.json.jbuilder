# frozen_string_literal: true

json.array! @results, partial: 'typeahead/typeahead', as: :result
