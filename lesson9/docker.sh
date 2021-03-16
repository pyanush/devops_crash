#Logging
set -e
LOG_F="docker_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

#clone
git clone https://github.com/PolyakPavlo/devops_crash.git
cd devops_crash
#build && run
docker build -t sql .
docker run -itd --rm -p 5050:5050 -v $(pwd):/opt/app sql

# commit && push
#pwd && ls -lah
#cp access.db ../
#git status
#git add .
#git commit -m "add db"
#git push
#cd ..
#rm -rf devops_crash
