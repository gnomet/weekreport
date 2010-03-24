# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_weekreport_session',
  :secret      => '3be3e50c7882c75f252ee5843df9d881254c111b20b0fad7a064b7f275ea05c8212ae8adba857b7726558dcf7170677bc4d15cc31df130f68d5ab453daf482e9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
