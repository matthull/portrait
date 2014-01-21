# Game Plan

I'm setting aside a 5 hour block for this exercise with about an hour to get my head in the code base and plan, and 4 hours of implementation time. Afterwards
I'll take about 30 min. to write it up.

Following are the two features I'll be working on along with a list of individual tasks I think will be required.
Starred items are 'must haves' that I feel I can get done in the allotted time. Items marked with ~~ are the ones I added later.
The remainder are 'should haves' that I'll get to if time allows.

## Secure Passwords
As a black hat who gained access to the Portrait database, I can't retrieve any user's plaintext password.

- ** On account creation or password change, store password digest rather than actual password in DB
- ** Update authentication method to correctly handle encrypted password from DB
- ** Add mass assignment protection for admin flag and password digest (if it isn't there already)
- ** Add migration to encrypt password for existing users
- ** Add some complexity requirements for passwords (if that isn't already there)

## Authentication Frontend
- ~~ Add login page
- ~~ Require login before accessing other pages
- ~~ Display username when user is logged in
- ~~ Add logout link
- ~~ Prevent access to Manage Users for non-admin users

## API Auth
As a developer who is programatically accessing Portrait, I can conveniently and securely authenticate my API calls.

- ** Add API Key generator to User model
- ** Add controller method to authenticate user based on key for API requests
- Respond with 401 if no key/bad key is provided
- Add migration to generate API keys for existing users
- Ability for user to create a new API key
- Ability for user to have multiple API keys
- Pass API key in Authentication header rather than in URL to avoid accidental key sharing
- Rather than passing API key in each request, use authenticate endpoint that provides time-limited session tokens
