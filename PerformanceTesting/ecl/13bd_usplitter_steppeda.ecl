//class=memory
//class=splitter

//Test the performance of an unbalanced splitter pulled out of step

//nohthor - hthor does not have splitters

//version stepsize=100,stepLength=200
//version stepsize=100,stepLength=2000
//version stepsize=10000,stepLength=20000

#onwarning (4550, ignore);

import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

stepSize := #IFDEFINED(root.stepSize, 10000);
stepLength := #IFDEFINED(root.stepLength, 20000);

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

r patchId(r l, unsigned step) := TRANSFORM
    unsigned seq := (l.id1 - 1) DIV stepLength;
    unsigned delta := IF(seq % 4 >= step, stepSize*step, 0);
    SELF.id2 := l.id1 + delta + stepLength * stepSize * (seq DIV 4);
    SELF := l;
END;

p1 := project(sharedDs(id1 != -1), patchId(LEFT, 1));
input1 := sorted(p1, id2, assert);
p2 := project(sharedDs(id1 != -2), patchId(LEFT, 2));
input2 := sorted(p2, id2, assert);

j := JOIN(input1, input2, LEFT.id2 = RIGHT.id2, LOCAL);

numSteps := numRecords DIV (stepLength*4);
ASSERT(numRecords = numSteps * stepLength * 4);
numMissing := numSteps * 2 * stepsize;

OUTPUT(COUNT(j) - (numRecords - numMissing) * CLUSTERSIZE); // 0 means the result is correct
