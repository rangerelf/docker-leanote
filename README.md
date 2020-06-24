# docker-leanote
Run leanote server in a docker container!

## Usage:
From the terminal:
```sh
$ make build
...
$ make run
...
```
Simple!!

## Details
The docker image contains mongodb, and stores the
data in the `/data` directory, which is marked
as a volume; you can use your own persistent
volume and bind it to that location.

MongoDB listens on localhost only, unless the
environment variable `MONGODB_ADDR` is overridden
with `0.0.0.0` (for example) so it listens on all
interfaces.  Not necessary, unless you're planning
on dumping the data as part of a backup plan.

Leanote serves on port `9000`, which you can bind
to another port outside the container, or however
you want to handle it.
