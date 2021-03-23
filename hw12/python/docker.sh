#Logging
set -e
LOG_F="docker_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

docker build -t python .
docker run -itd --rm -p 5050:5050 -v $(pwd):/opt/app python
