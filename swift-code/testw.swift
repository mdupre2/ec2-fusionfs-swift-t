import files;
import io;
import string;
import location;
import sys;
import random;


app (file o) writetest (int num){
    "/mnt/swift-run/write-test.sh" @o num;
}

app () readtest (file infile, int num){
    "/mnt/swift-run/read-test.sh" @infile num;
    
}

app (file loc) lookup (file infile){
    "/mnt/script/lookup" @infile @stdout=loc;
    
    
}

(location loc) lookupLocation (file infile){
    int randRank = randomWorkerRank();
    location randLocation = location(randRank, HARD, NODE);
    file hostname = @location=randLocation lookup(infile);
    
    string hn = trim(@location=randLocation read(hostname));
    trace(hn);
    int rank = hostmapOneWorkerRank(hn);
    
    
    loc = location(rank, SOFT, NODE);
}

main{

        for(int i = 0; i < toint(argv("nfiles")); i = i+1){
            string filename;
            if (toint(argv("optnum")) == 2){
                filename = "/mnt/write/file-"+i;
            }else{
                filename = "/mnt/script/fusion_mount/file-"+i;
            }
            
            
            file f <filename>;
            f = writetest(i);
            
        }
    
}

