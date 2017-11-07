CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     ENV['GC_ACCESS_KEY_ID'],
    google_storage_secret_access_key: ENV['GC_SECRET_ACCESS_KEY']
  }
  config.fog_directory = ENV['GC_folder']
end
