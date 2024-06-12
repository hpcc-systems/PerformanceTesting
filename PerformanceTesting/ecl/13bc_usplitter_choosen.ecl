//class=memory
//class=splitter

//Test the performance of an unbalanced splitter pulled in a balanced way

//nohthor - hthor does not have splitters

//version numMatches=100
//version numMatches=10000
//version numMatches=1000000


import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

numMatches := #IFDEFINED(root.numMatches, 1000);

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

sharedDs := SORTED(NOFOLD(ds)(id1 != 0), id1);

input1 := sharedDs(id1 != 1);
input2 := choosen(sharedDs(id1 != 2), numMatches, local);

j := JOIN(input1, input2, LEFT.id1 = RIGHT.id1, LOCAL, LEFT ONLY);

OUTPUT(COUNT(j) - (numRecords - numMatches) * CLUSTERSIZE); // 0 means the result is correct
