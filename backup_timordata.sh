DATE=`date -I -u`

docker exec -it timordata_db_1 pg_dump -U django -Z 0 -F d timordata.info -f /tmp/${DATE}
mkdir -p ~/backups/database
docker cp timordata_db_1:/tmp/${DATE} ~/backups/database
ln -s ~/backups/database/${DATE}  ~/backups/database/latest
cp -rvf ~/backups/database/${DATE}/* ~/backups/database/git
docker exec -it timordata_db_1 rm -rf /tmp/${DATE}
cd ~/backups/database/git
git add .
git commit -am "Update to ${DATE}"
git push origin master
