//class=memory
//class=quick
//class=create
//class=parallel

//nohthor - parallel queries not supported in hthor

//DATASET->PROJECT->COUNT

//- Single stranded performance - how does it scale with the the amount of work that needs to be done?
//version hintNumStrands=1,hintProjectWork=0,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=false
//version hintNumStrands=1,hintProjectWork=4,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=false
//version hintNumStrands=1,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=false
//version hintNumStrands=1,hintProjectWork=64,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=false
//version hintNumStrands=1,hintProjectWork=256,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=false

//- A reasonable number of strands (8), and reasonable work - how do the different versions of executing in parallel compare?
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=false
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=true
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=true,hintParallelCount=false,hintIsOrdered=false
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=true,hintParallelCount=false,hintIsOrdered=true
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=false,hintParallelCount=true,hintIsOrdered=false
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=false,hintParallelCount=true,hintIsOrdered=true
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=false
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=true

//The version that is executed completely in parallel - how does it improve with the number of strands?  
//version hintNumStrands=4,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=true
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=true
//version hintNumStrands=16,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=true
//version hintNumStrands=32,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=true
//version hintNumStrands=64,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=true
//version hintNumStrands=128,hintProjectWork=16,hintParallelSource=true,hintParallelCount=true,hintIsOrdered=true

//The version that has contention before and after the project   
//version hintNumStrands=4,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=true
//version hintNumStrands=8,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=true
//version hintNumStrands=16,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=true
//version hintNumStrands=32,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=true
//version hintNumStrands=64,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=true
//version hintNumStrands=128,hintProjectWork=16,hintParallelSource=false,hintParallelCount=false,hintIsOrdered=true
  
import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

hintNumStrands := #IFDEFINED(root.hintNumStrands, 16);
hintIsOrdered := #IFDEFINED(root.hintIsOrdered, false);
projectWork := #IFDEFINED(root.hintProjectWork, 4);
parallelSource := #IFDEFINED(root.hintParallelSource, false);
parallelCount := #IFDEFINED(root.hintParallelCount, false);

numRecords := 50000000;

unsigned8 performWork(unsigned8 value, unsigned iter) := BEGINC++
    #option pure
    for (unsigned i=0; i < iter; i++)
        value = rtlHash64Data(sizeof(value), &value, value);
    return value;
ENDC++;

r1 := { unsigned8 id };
r2 := { unsigned8 id, unsigned8 val; };

r1 createSimple(unsigned8 c) := TRANSFORM
    SELF.id := c;
END;

ds := DATASET(numRecords, createSimple(COUNTER), LOCAL, PARALLEL(IF(parallelSource,0,1)));

r2 t(r1 l) := TRANSFORM, SKIP(l.id % 5 = 6)
    SELF.id := l.id;
    SELF.val := performWork(l.id, projectWork);
END;

p := PROJECT(NOFOLD(ds), t(LEFT), PARALLEL(hintNumStrands),ORDERED(hintIsOrdered));

s := IF(hintIsOrdered, SORTED(NOFOLD(p), id, ASSERT), p);

cnt := NOFOLD(COUNT(NOFOLD(p), PARALLEL(IF(parallelCount,0,1))));

OUTPUT(cnt - numRecords * CLUSTERSIZE);// * 1 * 4 DIV 5);
