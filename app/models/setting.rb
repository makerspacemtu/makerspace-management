require "settings-manager"

class Setting < SettingsManager::Base
  allowed_settings_keys []
  default_settings_config Rails.root.join("config/default_settings.yml")
end
