# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_unagios_session',
  :secret      => 'fc223501b839875ac0408f6b484ab3d4f8c81cf6f997ed00f5b0325acc8cba1a9782703788ff006d6c5512f89e335506db69025fa58c99c81aaca993e773bad7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
