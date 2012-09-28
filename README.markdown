# George Armhold's fork of the LivingSocial Software Engineer challenge

My submission is in the form of a standard Rails 3.2.x app.

## Instructions

From a terminal, execute the following commands:

1. `bundle install`  -- this will install the required dependencies using bundler.
1. `rake db:migrate` -- this will create the initial (empty) database.
1. `rails s` -- this will start up the server

Now you can open a web browser and find the running application at: `http://localhost:3000`

There are some sample input files in `test/fixtures/files`, including some examples designed to
test bad-input processing.


## Tests

There are a few unit/integration tests included with the implementation. Tests can be run in the terminal with: `rake test`.

## Implementation Notes

### Authentication

The app is secured via OpenID. You will need a valid Google-based OpenID account to access the protected areas
of the application.

You can also try logging on with a different OpenID account to test the access control mechanism for
individual uploads.


### Persistence

The app uses Rails' standard sqlite3 for persistence. You can examine the table structure and
interact with the data using the sqlite client: `rails dbconsole`.
