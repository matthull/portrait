# Game Plan

I'm setting aside a 5 hour block for this exercise with about an hour to get my head in the code base and plan, and 4 hours of implementation time. Afterwards
I'll take about 30 min. to write it up.

Following are the ~~two~~ three major features I'll be working on along with a list of individual tasks I think will be required.
Starred items are 'must haves' that I feel I can get done in the allotted time. The remainder are 'should haves' that I'll get to if time allows.
Items with [X] I completed.

### Secure Passwords
As a black hat who gained access to the Portrait database, I can't retrieve any user's plaintext password.

- [X] ** On account creation or password change, store password digest rather than actual password in DB
- [X] ** Update authentication method to correctly handle encrypted password from DB
- ** Add mass assignment protection for admin flag and password digest (if it isn't there already)
- ** Add migration to encrypt password for existing users
- [X] ** Add some complexity requirements for passwords (if that isn't already there)

### Authentication Frontend
As a registered Portrait user, I have a pleasant and satisfying experience when logging in and out of the application.

- [X] ** Add login page
- [X] ** Require login before accessing other pages
- [X] ** Display username when user is logged in
- [X] ** Add logout link
- [X] ** Prevent access to Manage Users for non-admin users

### API Auth
As a developer who is programatically accessing Portrait, I can conveniently and securely authenticate my API calls.

- ** Add API Key generator to User model
- ** Add controller method to authenticate user based on key for API requests
- Respond with 401 if no key/bad key is provided
- Add migration to generate API keys for existing users
- Ability for user to create a new API key
- Ability for user to have multiple API keys
- Pass API key in Authentication header rather than in URL to avoid accidental key sharing
- Rather than passing API key in each request, use authenticate endpoint that provides time-limited session tokens

# After-Action Report

I added the Authentication Frontend tasks an hour in when I realized that I didn't have any tasks queued up that involved front-end work. Despite this
scope creep, I managed to finish the majority of the starred tasks in time. Still, I didn't get quite as much done as I expected.

I used the code for Rails 4 has_secure_password as my primary reference when designing the password encryption feature. It seemed like a good way to go since it represents
a recently implemented standard approach for Rails password encryption I like the object oriented nature of BCrypt::Password and the fact that it avoids having to store a salt
as a separate column in the DB.

I skipped adding a migration to encrypt existing plaintext passwords since I'm not familiar with a nice way to unit test migrations and wasn't sure how long it would
take to figure one out.

Had trouble getting the header to format correctly, so the username and logout link are pushed down the page some by the logo div. I've become more reliant
than I realized on CSS grid frameworks.

The critical thing that I ran out of time on was API authentication keys, which are very much needed now that HTTP basic auth is not in use.

I struggled a little with how to structure the controller tests now that there are a handful which require different session states (e.g. logged out or logged in as non-admin user).
Nested describe blocks, one for each user (and one for logged-out state), would be a pretty standard way to go, but it seemed like overkill just for a couple of tests.
I ended up leaving the before block that logs in 'jordan' for every test, and then logging him out where needed. It's probably controversial to undo test setup
this way but the ugliness of nested blocks just didn't seem worth it.
