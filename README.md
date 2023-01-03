# Survivor App

## Instalando projeto

É necessário ter Docker e docker-compose. A aplicação roda o banco e o server tudo em docker. Para instalar o projeto, siga estas etapas:

Setando o .env
```
copie o arquivo .env-example com o nome .env
```
depois rode
```
docker-compose -f docker-compose.local.yml up --build
```

Se tudo foi instalado com sucesso, estará rodando os containers postgres(port: 5432) e o server(port: 3000)

Agora, precisa criar o banco e rodar as migrations, para isso entre no container
```
docker exec -it survivor-app bash
```
e Rode:
```
rails db:create
rails db:migrate
```
## Use

No terminal, caso queira acessar o container do server, rode
```
docker exec -it survivor-app bash
```

## Tests

No terminal, caso queira rodar os testes, basta rodar o comando anterior e o comando a seguir:
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

