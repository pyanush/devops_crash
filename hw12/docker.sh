#Logging
set -e
LOG_F="docker_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

# docker build -t ftp .
# docker build -t python .
# docker build -t nginx .
docker-compose up --build -d
docker-compose ps
docker-compose stop
docker-compose down
# docker ps -a
#docker rm $(docker ps -aq) -f
#docker volume ls

#docker run -it --rm -p 5050:5050 -v $(pwd):/opt/data hw12_python
#docker-compose rm