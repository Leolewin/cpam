echo " <?xml version=\"1.0\"?>" >/tmp/pkg-db.xml
echo "<packages>"  >>/tmp/pkg-db.xml

for i in */pb-db.xml
do
echo $i
gen-pkg-db $i  | egrep -v "<packages>|</packages>|xml version="  >> /tmp/pkg-db.xml
done

echo " </packages>"  >>/tmp/pkg-db.xml