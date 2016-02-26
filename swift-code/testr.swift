import files;
import io;
import string;
import location;
import sys;
import random;


app (file o) writetest (int num){
    "/mnt/swift-run/write-test.sh" @o num;
}

app () readtest (string infile, int num){
    "/mnt/swift-run/read-test.sh" infile num;
}

app (file loc) lookup (string infile){
    "/mnt/script/lookup" infile @stdout=loc;
}

(location loc) lookupLocation (string infile){
    int randRank = randomWorkerRank();
    location randLocation = location(randRank, HARD, NODE);
    file hostname = @location=randLocation lookup(infile);
    
    string hn = trim(@location=randLocation read(hostname));
    //trace(hn);
    int rank = hostmapOneWorkerRank(hn);
    
    
    loc = location(rank, HARD, NODE);
}

// opt 0 : test regular read speeds with swift-t and fusionfs without location optimization
// opt 1 : test  read speeds with swift-t and fusionfs with location optimization


main{
        string s[];
        for(int i = 0; i < toint(argv("nfiles")); i = i+1){
            string filename;
            if (toint(argv("optnum")) == 2){
                filename = "/mnt/write/file-"+i;
            }else{
                filename = "/mnt/script/fusion_mount/file-"+i;
            }
            
            s[i] = filename;
        }
    
        foreach f, index in s{
            if (toint(argv("optnum")) == 0){
                readtest(f, index);
            }
            if (toint(argv("optnum")) == 1){
                location l = lookupLocation(f);
                @location=l readtest(f, index);
            }
            
        }
    
}

