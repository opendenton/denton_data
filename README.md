### A prototype of an ETL and API for Open Denton

This is a prototype of an application that imports data from [the city of Denton's open data project](http://data.cityofdenton.com/)
into a permanent schema, and offers a flexible API on top of that schema. The db is [PostgreSQL](https://www.postgresql.org/)
and the framework for the API is [Sinatra](http://www.sinatrarb.com/).

#### Install & bootstrap

- [Install PostgreSQL](http://www.postgresqltutorial.com/install-postgresql/)
- Make sure you have [ruby installed](https://www.ruby-lang.org/en/documentation/installation/)
- From the project directory, `gem install bundler`
- Then `bundle install`
- To bootstrap the db, run `sh bootstrap.sh`
- Then create the schema with `PGPASSWORD=password1 psql -d denton_data -U denton_data -f migrate.sql`

#### Running

- To import data from the city into the local schema: `bundle exec ruby app\models\import_denton_housing.rb`
- To run the server locally: `bundle exec ruby app\app.rb`
- See example APIs locally (the 'year' params can vary between 2008 and 2014):
  - http://localhost:4567/denton-housing
  - http://localhost:4567/total-housing-units?year=2009
  - http://localhost:4567/vacant_housing_units?year=2009
