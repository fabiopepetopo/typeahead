# frozen_string_literal: true

module DummyNamesHelper
  module_function

  def short_list
    rated_names = { 'Fa': 45, 'Fabi': 54, 'Fabio': 34, 'Ser': 12, 'Sergio': 145, 'Sergia': 145, 'Fabio Vaccaro': 31,
                    'Fabio-enzo': 10, 'fabbito': 1 }
    TypeaheadService.instance.initial_data(rated_names)
  end

  def case_sensitive_list
    rated_names = { 'FaB': 45, 'fab': 54, 'FAB': 34, 'fAB': 12, 'Ser': 145 }
    TypeaheadService.instance.initial_data(rated_names)
  end
end
