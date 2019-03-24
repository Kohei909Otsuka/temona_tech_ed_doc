docker-compose run app rake db:drop
docker-compose run app rake db:create
docker-compose run app rake db:migrate
docker-compose run app rake db:seed
