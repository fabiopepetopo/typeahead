# frozen_string_literal: true

Dir[Rails.root.join('lib', 'prefix', '*.rb')].sort.each { |f| require f }
