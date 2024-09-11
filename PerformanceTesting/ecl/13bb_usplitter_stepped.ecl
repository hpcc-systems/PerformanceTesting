//class=memory
//class=splitter

//Test the performance of an unbalanced splitter pulled constantly out of step

//nohthor - hthor does not have splitters

//version stepsize=100
//version stepsize=10000
//version stepsize=1000000
//version stepsize=20000000

import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

stepSize := #IFDEFINED(root.stepSize, 100);

numRecords := 20000000;

r := RECORD
    UNSIGNED id1;
    UNSIGNED id2;
END;

r createSimple(unsigned8 c) := TRANSFORM
    SELF.id1 := c;
    SELF.id2 := 0;
END;

ds  := DATASET(numRecords, createSimple(COUNTER), LOCAL);

sharedDs := NOFOLD(ds)(id1 != 0);

input1 := sorted(sharedDs(id1 != -1), id1 + stepsize, local);
input2 := sorted(sharedDs(id1 != -2), (integer)id1, local);

j := JOIN(input1, input2, LEFT.id1 + stepsize = RIGHT.id1, LOCAL);

OUTPUT(COUNT(j) - (numRecords - stepsize) * CLUSTERSIZE); // 0 means the result is correct
