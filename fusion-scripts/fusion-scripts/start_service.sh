#start the service for file transfer
/home/ubuntu/fusion/src/ffsnet/ffsnetd  2>&1 1>/dev/null &  

#start the service for ZHT server
 /home/ubuntu/fusion/src/zht/zhtserver -n /home/ubuntu/fusion/conf/neighbor.conf -z /home/ubuntu/fusion/conf/zht.conf  2>&1 1>/dev/null &
