Application.configure do |configuration|
  configuration.logger.level = Logger::INFO

  configuration.session_secret = ENV.fetch("SESSION_SECRET")

  configuration.database.host = ENV.fetch("DB_HOST")
  configuration.database.database = ENV.fetch("DB_DATABASE")
  configuration.database.username = ENV.fetch("DB_USERNAME")
  configuration.database.password = ENV.fetch("DB_PASSWORD")
end
