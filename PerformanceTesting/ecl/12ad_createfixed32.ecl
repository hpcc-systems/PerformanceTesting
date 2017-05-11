//class=memory
//class=quick
//class=create
//class=parallel

//nohthor - parallel queries not supported in hthor
//nothor - thor does not currently support parallel inline datasets but should!

//Test how the different options affect the speed of a M:1 junction
 
//version hintNumStrands=2,hintBlockSize=1,hintStrandOrdered=true
//version hintNumStrands=4,hintBlockSize=1,hintStrandOrdered=true
//version hintNumStrands=6,hintBlockSize=1,hintStrandOrdered=true
//version hintNumStrands=8,hintBlockSize=1,hintStrandOrdered=true
//version hintNumStrands=16,hintBlockSize=1,hintStrandOrdered=true
//version hintNumStrands=32,hintBlockSize=1,hintStrandOrdered=true

//version hintNumStrands=2,hintBlockSize=100,hintStrandOrdered=true
//version hintNumStrands=4,hintBlockSize=100,hintStrandOrdered=true
//version hintNumStrands=6,hintBlockSize=100,hintStrandOrdered=true
//version hintNumStrands=8,hintBlockSize=100,hintStrandOrdered=true
//version hintNumStrands=16,hintBlockSize=100,hintStrandOrdered=true
//version hintNumStrands=32,hintBlockSize=100,hintStrandOrdered=true

//version hintNumStrands=2,hintBlockSize=500,hintStrandOrdered=true
//version hintNumStrands=4,hintBlockSize=500,hintStrandOrdered=true
//version hintNumStrands=6,hintBlockSize=500,hintStrandOrdered=true
//version hintNumStrands=8,hintBlockSize=500,hintStrandOrdered=true
//version hintNumStrands=16,hintBlockSize=500,hintStrandOrdered=true
//version hintNumStrands=32,hintBlockSize=500,hintStrandOrdered=true

//version hintNumStrands=2,hintBlockSize=500,hintStrandOrdered=false
//version hintNumStrands=4,hintBlockSize=500,hintStrandOrdered=false
//version hintNumStrands=6,hintBlockSize=500,hintStrandOrdered=false
//version hintNumStrands=8,hintBlockSize=500,hintStrandOrdered=false
//version hintNumStrands=16,hintBlockSize=500,hintStrandOrdered=false
//version hintNumStrands=32,hintBlockSize=500,hintStrandOrdered=false

//version hintNumStrands=2,hintBlockSize=2000,hintStrandOrdered=true
//version hintNumStrands=4,hintBlockSize=2000,hintStrandOrdered=true
//version hintNumStrands=6,hintBlockSize=2000,hintStrandOrdered=true
//version hintNumStrands=8,hintBlockSize=2000,hintStrandOrdered=true
//version hintNumStrands=16,hintBlockSize=2000,hintStrandOrdered=true
//version hintNumStrands=32,hintBlockSize=2000,hintStrandOrdered=true

//version hintNumStrands=2,hintBlockSize=8000,hintStrandOrdered=true
//version hintNumStrands=4,hintBlockSize=8000,hintStrandOrdered=true
//version hintNumStrands=6,hintBlockSize=8000,hintStrandOrdered=true
//version hintNumStrands=8,hintBlockSize=8000,hintStrandOrdered=true
//version hintNumStrands=16,hintBlockSize=8000,hintStrandOrdered=true
//version hintNumStrands=32,hintBlockSize=8000,hintStrandOrdered=true

import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;
import suite.perform.format;

hintNumStrands := #IFDEFINED(root.hintNumStrands, 8);
hintBlockSize := #IFDEFINED(root.hintBlockSize, 128);
hintStrandOrdered := #IFDEFINED(root.hintStrandOrdered, false);

scale := 8;

ds  := DATASET(config.simpleRecordCount*scale, format.createSimple(COUNTER),DISTRIBUTED,PARALLEL(hintNumStrands),ORDERED(hintStrandOrdered),HINT(strandBlockSize(hintBlockSize)));

cnt := COUNT(NOFOLD(ds),PARALLEL(0));

OUTPUT(cnt - config.simpleRecordCount*scale = 0);
