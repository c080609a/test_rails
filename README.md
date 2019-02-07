### Инструкция по запуску

```bash
# нужно запустить docker
$ docker-compose up -d

# нужно создать базы и сиды
$ docker-compose exec web bundle exec rake db:drop
$ docker-compose exec web bundle exec rake db:create
$ docker-compose exec web bundle exec rake db:migrate
$ docker-compose exec web bundle exec rake db:seed
```

