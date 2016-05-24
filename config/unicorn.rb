working_directory '/srv/gdash'
worker_processes (ENV['WORKERS'] || 4)
preload_app true
timeout 60

unless system 'erb config/gdash.yaml.erb >config/gdash.yaml'
  abort 'Failed to generate config/gdash.yaml'
end
