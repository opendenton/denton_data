### Open Denton API

Hello! This page contains information on the API endpoints currently available,
and will be updated as we add more. If there's a dataset you'd like added, please
reach out to us on Slack via the `#opendenton-api` channel. Or, just come stick
your head into the front conference room.

If you need help, or want to install the application locally, see [the readme]
on our GitHub repository.

## Endpoints

All endpoints are assuming a request of the type `GET`.


## API Base: [https://dentondata.herokuapp.com/](https://dentondata.herokuapp.com/)

The following routes are available:

---

### `/`

Home route, currently just returns a string.

---

### `/denton-housing`

Returns all housing data. [Original](http://data.cityofdenton.com/dataset/denton-tx-housing-data).

---

### `/total-housing-units[?year=]`

Returns all housing data by `year` [required].

---

### `/vacant-housing-units[?year=]`

Returns _vacant_ housing, by `year` [required].

---

### `/homelessness-survey`

Returns all "Point in Time Home Count Denton County". [Original](http://data.cityofdenton.com/dataset/point-in-time-home-count-denton-county).

---

### `/well-inspections`

Returns all "Gas Wells - Inspections Layer" data. [Original](http://data.cityofdenton.com/dataset/gas-wells-inspections-layer)

---

### `/demographics`

Returns all "Denton, TX Demographic Data". [Original](http://data.cityofdenton.com/dataset/denton-tx-demographic-data).

---

### `/demographics/:year`

Returns Demographic data by year [optional].

---

### `/economics`

Returns all "Denton, TX Economic Data". [Original](http://data.cityofdenton.com/dataset/denton-tx-economic-data).

---

### `/voter-districts`

Returns all "Voter Districts". [Original](http://data.cityofdenton.com/dataset/voter-districts).



[the readme]: https://github.com/OpenDenton/denton_data
