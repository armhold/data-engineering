# George Armhold's fork of the LivingSocial Software Engineer challenge

My submission is in the form of a standard Rails 3.2.x app.

## Instructions

From a terminal, execute the following commands:

1. `bundle install`
1. `rails s`
1. In another terminal window, execute: `open http://localhost:3000`

## Tests

There are a few unit/integration tests included with the implementation. Tests can be run in the terminal with: `rake test`.

## Implementation Notes

### Authentication

The app is secured via OpenID. You will need a valid Google-based OpenID account to access the protected areas
of the application.


### Persistence

The app uses Rails' standard sqlite3 for persistence. You can examine the table structure and
interact with the data using the sqlite3 client: `bundle exec sqlite3 db/development.sqlite3`.
