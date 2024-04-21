# config/initializers/session_store.rb

Rails.application.config.session_store :active_record_store, key: '_eventful_ease_session_#{Time.current.to_i}'
Rails.application.config.session_store :cookie_store, key: '_eventful_ease_session'
