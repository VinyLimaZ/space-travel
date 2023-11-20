# README

Hello guys, I'm Vinicius and that's my solution for the problem you brought to
me :D

## Versions
* Ruby version
3.2.1
* Rails version
7.1.1
* Postgres version
14.9

# How to?

## Setting up the application via Docker

### Configuring and Launching the Environment for the First Time

To set up the environment correctly, the following tools are required:

* Docker (how to [here](https://docs.docker.com/engine/install/ubuntu/))
* After installing Docker, it is also recommended to follow the post-installation steps available [here](https://docs.docker.com/engine/install/linux-postinstall/).
* Docker Compose (how to [here](https://docs.docker.com/compose/install/linux/))

### Running Services
The project environment depends on 2 containers specified in the `docker-compose.yml` file.
The project is configured to be automatically executed via `docker compose` using the following command:

```
docker compose up
```
When executed for the first time, the system downloads container images and configures the environment automatically from the `env.dev` file.

After all services are started, the space-travel application will be available at the address `localhost:3000`.

Upon completing the environment setup, the `start.sh` script is automatically executed,
where the Postgres database is created, configured (using the commands `rake db:setup`) and
a `seed` is executed containing some models to populate the system.

### Endpoints
- Assure that you're sending the `content-type: application/json` header!

#### Spacecrafts
- `GET /spacecrafts` -> show all spacecrafts
- `GET /spacecrafts/:id` -> show a specific spacecraft

#### Rockets
- `GET /rockets` -> show all rockets
- `GET /rockets/:id` -> show a specific rocket
- `POST /rockets` -> create a new rocket
- `PATCH /rockets/:id` -> edit a rocket

#### SpaceShuttles
- `GET /space_shuttles` -> show all space_shuttles
- `GET /space_shuttles/:id` -> show a specific space_shuttle
- `POST /space_shuttles` -> create a new space_shuttle
- `PATCH /space_shuttles/:id` -> edit a space_shuttle

#### Ufos
- `GET /ufos` -> show all ufos
- `GET /ufos/:id` -> show a specific ufo
- `POST /ufos` -> create a new ufo
- `PATCH /ufos/:id` -> edit a ufo

#### Travels
- `GET /travels` -> show all travels
- `GET /travels/:id` -> show a specific travel
- `POST /travels` -> create a new travel
- `PATCH /travels/:id` -> edit a travel

#### Schemas

- Rocket, SpaceShuttles and Ufos creation/update:

```json
{
  "name": :string,
  "velocity": :integer,
  "space_agency_id": :primary_key,
  "fuel_in_days": :integer,
  ADDENDUM
}
  ```
#### Addendum part

- Rockets
```json
"rocket_datum_attributes": {
  "payload_id": :primary_key
}
```

- SpaceShuttles
```json
"space_shuttle_datum_attributes": {
  "max_crew_size": :integer
}
```
- Ufos
```json
"ufo_datum_attributes": {
  "max_crew_size": :integer
}
```

- Travels creation

```json
{
  "beginning_date": :date 'YYYY-MM-DD',
  "duration": integer,
  "planet_id": :primary_key,
  "spacecraft_id": :primary_key,
  "description": :string
}
```

- Travels update
```json
{
  "beginning_date": :date 'YYYY-MM-DD',
  "duration": integer,
  "planet_id": :primary_key,
  "spacecraft_id": :primary_key,
  "description": :string
  "status": :string/:integer
}
```

#### Valid status:

- `"scheduled"` or `0`
- `"started"` or `1`
- `"aborted"` or `2`
- `"failed"` or `3`
- `"finished"` or `4`

## A little explanation about my solution:

Regrettably, I was unable to complete all the requested apps in the test.

I had to revise the spacecraft modeling extensively before arriving at the
current solution involving STI and a straightforward entity-attribute-value
abstraction.

I opted against creating Spacecraft as a genuine abstract class due to the
constraints of STI and the envisioned API's method of returning all spacecraft.

While I could have implemented a more sophisticated state machine, I chose to
develop a Validator during the allotted time to ensure the proper status
transitions and block any unauthorized transitions.

==============================================================

Enjoy and hire me, please (͡ ° ͜ʖ ͡ °)

==============================================================
