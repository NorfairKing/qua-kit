### siren

Siren is a geometry scenario management service.
It is meant to be used with Luci/helen communication servers.

#### Requirements

The service is base on PostgreSQL database and its extension PostGIS.
This means that to build and run the service, you need to install those.
On Ubuntu 16.04 I am using following command for this purpose:
```
  sudo apt-get install postgresql postgis libpq-dev
```
Currently, `postgresql` package refers to `postgresql-9.5`,
`postgis` package refers to `postgresql-9.5-postgis-2.2`,
and `libpq-dev` is a library required to build PostgreSQL client applications.


### Setting up a database

I download osm map from http://ftp.snt.utwente.nl/pub/misc/openstreetmap/

First, you need to create a user and a database:
```
  psql -c "CREATE USER siren WITH PASSWORD 'sirenpass';"
  psql -c "CREATE DATABASE sirendb;"
  psql -c "GRANT ALL PRIVILEGES ON DATABASE sirendb to siren;"
  psql -d sirendb -c "CREATE EXTENSION postgis;"
  psql -d sirendb -c "CREATE EXTENSION postgis_topology;"
  psql -d sirendb -c "CREATE EXTENSION hstore;"
  
```
Then, upload the whole planet osm using following command (it takes a long long time):
```
  osm2pgsql -c -d sirendb --slim -C 10000 -E 4326 --keep-coastlines -k \
      --flat-nodes <a file to save flat nodes> planet-latest.osm.pbf
```

#### Example from osm2pgsl help

A typical command to import a full planet is
    osm2pgsql -c -d gis --slim -C <cache size> -k \
      --flat-nodes <flat nodes> planet-latest.osm.pbf
where
    <cache size> is 20000 on machines with 24GB or more RAM 
      or about 75% of memory in MB on machines with less
    <flat nodes> is a location where a 19GB file can be saved.

A typical command to update a database imported with the above command is
    osmosis --rri workingDirectory=<osmosis dir> --simc --wx - \
      | osm2pgsql -a -d gis --slim -k --flat-nodes <flat nodes> 
where
    <flat nodes> is the same location as above.
    <osmosis dir> is the location osmosis replication was initialized to.



#### NB on using Atom

Just as a reminder:
if using atom editor with `haskell-ghc-mod`, you need to build a `ghc-mod` executable
in the project folder.
Therefore, to install ghc-mod, type following:
```
  stack setup
  stack build happy
  stack build ghc-mod
```
Also, do not forget to remove folder `dist` if cabal created it,
and make sure atom plugin uses stack sandboxing.