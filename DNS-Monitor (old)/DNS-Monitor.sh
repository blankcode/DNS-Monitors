## Arguments
OPTS=$(getopt -o hstw "$@")
eval set -- "$OPTS"
while true
  do
    case "$1" in
      -h) help; shift;;
      -s) SERVER=$2; shift 2;;
      -t) TARGET=$2; shift 2;;
      -w) WAIT=$2; shift 2;;
      --) shift; break;;
    esac; 
done; 

echo "Starting DNS-Monitor..."; 
myDATE=$(date "+%Y%m%d-%H:%M:%S%z"); 

echo "Date-Time,NS Used,host,Query Time" | tee -a DNS-Monitor-$myDATE.txt; 

while true;
do 
	echo "$(date "+%Y%m%d-%H:%M:%S%z"),@SERVER,&TARGET,$(dig @SERVER &TARGET | grep Query | cut -d\  -f4,5)" | tee -a DNS-Monitor-$myDATE.txt; 
	sleep $WAIT; 
done