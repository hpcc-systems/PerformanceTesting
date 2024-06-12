//class=memory
//class=splitter

//Test the performance of an unbalanced splitter pulled in a balanced way

//nohthor - hthor does not have splitters

//    RHFnone             = 0x0000,
//    RHFpacked           = 0x0001,
//    RHFhasdestructor    = 0x0002,
//    RHFunique           = 0x0004,  // create a separate fixed size allocator
//    RHFoldfixed         = 0x0008,  // Don't create a special fixed size heap for this
//    RHFvariable         = 0x0010,  // only used for tracing
//    RHFblocked          = 0x0040,  // allocate blocks of rows
//    RHFscanning         = 0x0080,  // scan the heaplet for free items instead of using a free list
//    RHFdelayrelease     = 0x0100,

//version writemax=500
//version writemax=1000
//version writemax=2000
//version writemax=4000

//yversion useVariableRecords=false
//yversion useVariableRecords=true

//xversion heapOptions=0
//xversion heapOptions=1
//xversion heapOptions=4
//xversion heapOptions=5
//With blocked
//xversion heapOptions=64
//xversion heapOptions=65
//xversion heapOptions=68
//xversion heapOptions=69
//Scanning
//xversion heapOptions=128
//xversion heapOptions=129
//xversion heapOptions=132
//xversion heapOptions=133
//Scanning,blocked
//xversion heapOptions=192
//xversion heapOptions=193
//xversion heapOptions=196
//xversion heapOptions=197
//Scanning,delay release
//xversion heapOptions=384
//xversion heapOptions=385
//xversion heapOptions=388
//xversion heapOptions=389
//Scanning,blocked.delay-release
//xversion heapOptions=448
//xversion heapOptions=449
//xversion heapOptions=452
//xversion heapOptions=453

import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

spillHeapOptions := #IFDEFINED(root.heapOptions, 196);
useVariableRecords := #IFDEFINED(root.useVariableRecords, false);
writeAheadMax  := #IFDEFINED(root.writemax, 1024);

#option ('spillheapflags', spillHeapOptions);
#option ('splitterWriteAheadK', writeAheadMax);

numRecords := 20000000;

r := RECORD
    UNSIGNED id1;
    UNSIGNED id2;
#if (useVariableRecords)
    string extra;
#end
END;

r createSimple(unsigned8 c) := TRANSFORM
    SELF.id1 := c;
    SELF.id2 := 0;
#if (useVariableRecords)
    SELF.extra := (string)c;
#end
END;

ds  := DATASET(numRecords, createSimple(COUNTER), LOCAL);

sharedDs := SORTED(NOFOLD(ds)(id1 != 0), id1);

input1 := sharedDs(id1 != 1);
input2 := sharedDs(id1 != 2);

j := JOIN(input1, input2, LEFT.id1 = RIGHT.id1, LOCAL);

OUTPUT(COUNT(j) - (numRecords -2) * CLUSTERSIZE); // 0 means the result is correct
