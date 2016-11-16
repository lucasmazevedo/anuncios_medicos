# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:created_at] = "%d/%m/%Y às %H:%M"
Time::DATE_FORMATS[:date] = "%B de %Y"

