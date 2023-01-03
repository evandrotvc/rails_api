# Survivor App

## Description
RESTful API that stores survivors from a zombie apocalypse and allow
them to find the closest survivor from their location.
- Create new survivors - name, gender and current location (latitude/ longitude)
- Retrieve a survivor - survivor id required
- Update a survivor
- Retrieve closest survivor from a survivor - survivor id required, you can use
only latitude or longitude to calculate it. This is to help a survivor to identify who is
closer.
- Mark survivor as infected - A survivor is marked infected when at least 3 others
survivors report that it is infected.

## Instalando projeto

Docker and docker-compose are required. The application runs the database and the server all in docker. To install the project, follow these steps:

Setting the .env
```
copy the .env-example file with the name .env
```
after run:
```
docker-compose -f docker-compose.local.yml up --build
```

If everything was successfully installed, the postgres(port: 5432) and server(port: 3000) containers will be running

Now, you need to create the database and run the migrations, for that enter the container
```
docker exec -it survivor-app bash
```
and Run:
```
rails db:create
rails db:migrate
```
## Use

In the terminal, if you want to access the server's container, run
```
docker exec -it survivor-app bash
```

## Tests

In the terminal, if you want to run the tests, just run the previous command and the following command:
```
rspec
```

# Docs

## Person routes

- GET: Show => people/person_id => show person by id
- GET: Index => people/ => list all peoples
- POST: create => people/ => create person
    - Params (body):
      - name (string)
      - gender (string)
      - latitude (float)
      - longitude (float)
- PUT: update => people/person_id => update fields
- PATCH: update => people/person_id => update  one field
- DELETE: destroy => people/person_id => delete person by id
- POST: infected => people/person_id/survivors/person_target_id/infected => mark person as infected by person_target_id
  - person_target_id is the id other person that you want to mark
  - obs: The person target only marked as infected, when receive at least 3 others survivors report
- GET: closest => people/person_id/closest => show the person closest from person_id and show distance that person


### Examples
- Create
![alt text](https://github.com/evandrotvc/survivor/blob/main/app/assets/images/create.png)
- UPDATE
![alt text](https://github.com/evandrotvc/survivor/blob/main/app/assets/images/put.png)
- Closest
![alt text](https://github.com/evandrotvc/survivor/blob/main/app/assets/images/closest.png)
- Mark as infected
![alt text](https://github.com/evandrotvc/survivor/blob/main/app/assets/images/infected.png)

## Schema

### Person
- name (string)
- gender (string)
- status (enum string) [survivor, infected, dead]
- latitude (float)
- longitude (float)

### MarkSurvivor
This Model provides a counter the marks. If the id from person_marked appeared at least 3 times, will update o status that person to infected, through callback
- person_report (fk from person)
- person_marked (fk from person)

