#ec2-fusionfs-swift-t

##Setup
1. Create ec2 instances. All insances must have FusionFS installed in the same location. Having all the instances look the same is helpful. 
2. Fill in `ec2-config` file. Note that any environment variables exported in ~/.bashrc of the instance will not be exported. Export all environment variables in ~/.profile. 
3. If you don't have a AWS user with **administative permissions**, [create a user](http://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingCredentials.html). 
4. Use the downloaded credentials to fill in `AWS_ACCESS_KEY` and `AWS_SECRET_KEY` in `ec2-config` in both swift-scripts and fusion-scripts directory


##Scripts assume the following exists on each node:
* a directory /mnt/swift-run
* fusion mount directory path is /mnt/script/fusion_mount
* read-test.sh is located in /mnt/swift-run
* write-test.sh is located in /mnt/swift-run
* lookup executable is located in /mnt/script
* There exists an empty directory /mnt/work
* You probably have to change the permissions of /mnt directory: `sudo chmod 0777 /mnt`
* It is recommended that you disable strict host checking on head node :`echo -e "Host *\n\tStrictHostKeyChecking no" > ~/.ssh/config`

##Test Scripts

###test-allSizes
Usage : `test-allSizes`
Runs test-all with each cluster size: 33, 17, 9, 5 . (these numbers include the head node)
Make sure head node ip must be at the first ip in private_ip.txt, public_ip.txt files in both swift-scripts and fusion-scripts.
**This script may have a bug in it:** may be better to do test with various cluster sizes using test-all.

 

###test-all
Usage : `test-start <n-proc>`
runs test-start 3 times with each opt number:  0,1,2
adds row to csv files in data directory with results.


###test-start
Usage : `test-start <n-proc> <opt-num>`
Performs read/write test with 64 files of 1024 bytes using n-proc processes

* opt 0 : (uses testr0.tic & testw0.tic) test regular read speeds with swift-t and fusionfs without location optimization
	files written and read from /mnt/script/fusion_mount  on nodes

* opt 1 : (uses testr1.tic & testw1.tic) test  read speeds with swift-t and fusionfs with location optimization
 	files written and read from /mnt/script/fusion_mount on nodes. 
	(Opt 0 and 1 perform the same write test on fusionfs only the reads vary)
 
* opt 2 :(testw2.tic) only tests local writes with swift-t without fusionfs. No read tests.
 	Files are written to /mnt/write on nodes

Prints results to stdout. If using the script by itself call test-init first.

##swift-code & lookup
swift-code directory contains the swift code that performs the write test (testw.swift) and read test (testr.swift). These are already compiled and stored in swift-scripts:

* testr0.tic: testr.swift compiled with opt 0
* testr1.tic: testr.swift compiled with opt 1
* testw0.tic: testw.swift compiled with opt 0
* testw1.tic: testw.swift compiled with opt 1
* testw2.tic: testw.swift compiled with opt 2

These swift scripts call the following bash scripts/executables which should be stored on nodes

* read-test.sh: should be stored in /mnt/swift-run/ on nodes
* write-test.sh: should be stored in /mnt/swift-run/ on nodes
* lookup: compiled from lookup.cpp should be stored in /mnt/script/lookup

Copies of read-test.sh and write-test.sh are found in swift-scripts directory
lookup.cpp with make file are found in lookup-src directory


