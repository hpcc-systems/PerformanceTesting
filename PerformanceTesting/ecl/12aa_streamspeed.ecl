//class=memory
//class=quick
//class=create
//class=parallel

//nohthor - parallel queries not supported in hthor

//Test to see how the performance of parallel inlinetable->project->count depends on the work that is being done and on the number of strands
//Really test 12ac_parallelproject supersedes this test  

//version hintNumStrands=1,hintBlockSize=512,hintWriteWork=4,hintReadWork=0,hintIsOrdered=true
//version hintNumStrands=6,hintBlockSize=512,hintWriteWork=4,hintReadWork=0,hintIsOrdered=true
//version hintNumStrands=6,hintBlockSize=512,hintWriteWork=4,hintReadWork=0,hintIsOrdered=false

//version hintNumStrands=1,hintBlockSize=512,hintWriteWork=16,hintReadWork=0,hintIsOrdered=true
//version hintNumStrands=6,hintBlockSize=512,hintWriteWork=16,hintReadWork=0,hintIsOrdered=true
//version hintNumStrands=6,hintBlockSize=512,hintWriteWork=16,hintReadWork=0,hintIsOrdered=false

//version hintNumStrands=1,hintBlockSize=512,hintWriteWork=64,hintReadWork=0,hintIsOrdered=true
//version hintNumStrands=6,hintBlockSize=512,hintWriteWork=64,hintReadWork=0,hintIsOrdered=true
//version hintNumStrands=6,hintBlockSize=512,hintWriteWork=64,hintReadWork=0,hintIsOrdered=false


import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

hintNumStrands := #IFDEFINED(root.hintNumStrands, 8);
hintBlockSize := #IFDEFINED(root.hintBlockSize, 1024);
hintIsOrdered := #IFDEFINED(root.hintIsOrdered, false);
writeWork := #IFDEFINED(root.hintWriteWork, 4);
readWork := #IFDEFINED(root.hintReadWork, 0);

numRecords := 200000000;

unsigned8 performWork(unsigned8 value, unsigned iter) := BEGINC++
    #option pure
    for (unsigned i=0; i < iter; i++)
        value = rtlHash64Data(sizeof(value), &value, value);
    return value;
ENDC++;

{ unsigned8 id } createSimple(unsigned8 c) := TRANSFORM
    SELF.id := performWork(c, writeWork);
END;

ds  := DATASET(numRecords, createSimple(COUNTER), LOCAL, PARALLEL(hintNumStrands),ORDERED(hintIsOrdered),HINT(strandBlockSize(hintBlockSize),heap(0x80)));

readDs := NOFOLD(ds)(performWork(id, readWork) * NOFOLD(0) = 0);
cnt := COUNT(NOFOLD(readDs));

OUTPUT(cnt - numRecords * CLUSTERSIZE = 0);
