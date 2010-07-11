# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SistemaGDE_session',
  :secret      => '125071f84c6f18aaca48a9300444c59820d3b7dc058d8a8beaa9d42e4458187984c30d384c1cbd892054c5cee971c3ba8a90d2f5b244f869710d8e7a362369d6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
