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
- Run `rake db:create db:schema:load`

#### Running

- To run the server locally: `bundle exec ruby app/app.rb`
- To import all available data, go to `<host[:port]>/import-data`
- To delete all current data, go to `<host[:port]>/delete-data`
- See example APIs locally (the 'year' params can vary between 2008 and 2014):
  - http://localhost:4567/denton-housing
  - http://localhost:4567/total-housing-units?year=2009
  - http://localhost:4567/vacant-housing-units?year=2009

## Troubleshooting

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

---

If the app crashes with the following warning:

```
$ ActiveRecord::ConnectionTimeoutError - could not obtain a connection from the pool within 5.000 seconds (waited 5.001 seconds); all pooled connections were in use:
```

You broke it!

Just kidding.. but the app will need to be restarted. We still need to build in
some logic for handling blocking calls. Thanks fer yor patience!



## Data Import

1. Browse http://data.cityofdenton.com/dataset
1. Find Dataset, click on CSV
1. Select CSV, Explore, Preview
1. Select `Data API` and find "Query Example (first 5 results)", grab `resource_id` value

For examples below, the Resource ID is `5980ea98-ce00-4f7d-9ee3-114006f78f59` and the DB table will be `gas_well_inspections`.

1. in terminal open `pry`
1. `load 'app/data_importer.rb'`
1. `DataImporter.get_sampling('5980ea98-ce00-4f7d-9ee3-114006f78f59', 'gas_well_inspections')`
1. `load 'app/data_saver.rb'`
1. `DataSaver.save_all('5980ea98-ce00-4f7d-9ee3-114006f78f59', 'gas_well_inspections')`

Files

1. Stage `app/app.rb` and `schema.rb`
1. Add new model in `app/models` e.g. `app/models/gas_well_inspection.rb`
1. Add new migration in `db/migrate`
1. Commit on feature branch