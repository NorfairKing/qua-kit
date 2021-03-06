psql -U postgres -c "CREATE USER siren WITH PASSWORD 'sirenpass';"
psql -U postgres -c "CREATE DATABASE sirendb;"
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE sirendb to siren;"
psql -U postgres -d sirendb -c "CREATE EXTENSION IF NOT EXISTS postgis;"
psql -U postgres -d sirendb -c "CREATE EXTENSION IF NOT EXISTS postgis_topology;"
psql -U postgres -d sirendb -c "GRANT SELECT, INSERT, REFERENCES ON TABLE spatial_ref_sys to siren;"
