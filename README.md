### A prototype of an ETL and API for Open Denton

This is a prototype of an application that imports data from [the city of Denton's open data project](http://data.cityofdenton.com/)
into a permanent schema, and offers a flexible API on top of that schema. The db is [PostgreSQL](https://www.postgresql.org/)
and the framework for the API is [Sinatra](http://www.sinatrarb.com/).

#### Install & bootstrap

- Install PostgreSQL
  - [Mac](https://launchschool.com/blog/how-to-install-postgresql-on-a-mac)
  - [Windows](http://www.postgresqltutorial.com/install-postgresql/)
- Make sure you have [ruby installed](https://www.ruby-lang.org/en/documentation/installation/)
- From the project directory, `gem install bundler`
- Then `bundle install`
- Run `rake db:create db:migrate`

#### Running

- To import data from the city into the local schema: `bundle exec ruby app/models/import_denton_housing.rb`
- To run the server locally: `bundle exec ruby app/app.rb`
- See example APIs locally (the 'year' params can vary between 2008 and 2014):
  - http://localhost:4567/denton-housing
  - http://localhost:4567/total-housing-units?year=2009
  - http://localhost:4567/vacant_housing_units?year=2009

### Troubleshooting

If you get the following error:
```
➜ psql: FATAL:  database "<user>" does not exist
```
Run the shell command, `createdb`. This creates a database with the name of the current user.

Source: [Stack Overflow Article](http://stackoverflow.com/questions/17633422/psql-fatal-database-user-does-not-exist).

---

If you used Brew to install Postgres, you can also use [services](https://robots.thoughtbot.com/starting-and-stopping-background-services-with-homebrew)
to start and stop the `psql` background service.

```raw
➜ brew tap homebrew/services        ## if you don't have it already installed
➜ brew services start postgresql
➜ brew services start postgresql
```
