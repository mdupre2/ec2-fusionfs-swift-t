#include <error.h>
#include <unistd.h>
#include "Util.h"
#include "cpp_zhtclient.h"


using namespace std;
using namespace iit::datasys::zht::dm;



int lookup(string &zhtConf, string &neighborConf,const string &key, string &result){
	ZHTClient zClient;	
	if (zClient.init(zhtConf, neighborConf) != 0) {
            cout << "ZHTClient initialization failed, program exits." << endl;
            return -1;
        }
	int ret = zClient.lookup(key, result);
	zClient.teardown();
	return ret;
} 

int main(int argc, char **argv) {
  if (argc < 2 ){
	cout << "usage: lookup key \n";
	return -1;
   }
   else{
	string zhtConf = "/home/ubuntu/fusion/conf/zht.conf";
        string neighborConf = "/home/ubuntu/fusion/conf/neighbor.conf";
	string result = "";
	string key = string(argv[1]);
	int ret = lookup(zhtConf, neighborConf, key, result);
	cout << result;
	return ret;

   }
   
}

