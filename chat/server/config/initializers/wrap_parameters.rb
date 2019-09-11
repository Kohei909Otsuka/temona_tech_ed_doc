# Be sure to restart your server when you modify this file.

# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

# Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
ActiveSupport.on_load(:action_controller) do
  # https://stackoverflow.com/questions/27672954/rails-duplicated-the-parameters-inside-the-resource
  # edited by kohei
  wrap_parameters format: []
end

# To enable root element in JSON for ActiveRecord objects.
# ActiveSupport.on_load(:active_record) do
#   self.include_root_in_json = true
# end
