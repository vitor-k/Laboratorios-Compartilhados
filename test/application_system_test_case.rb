require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium_headless, using: :firefox, screen_size: [1400, 1400]
end
