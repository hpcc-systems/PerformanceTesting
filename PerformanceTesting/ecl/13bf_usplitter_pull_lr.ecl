//class=memory
//class=splitter

//Test the performance of an unbalanced splitter, right pulled via a lookahead

//nohthor - hthor does not have splitters


import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

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
input2 := sharedDs(id1 != 2);

j := JOIN(PULL(input1), PULL(input2), LEFT.id1 = RIGHT.id1, LOCAL);

OUTPUT(COUNT(j) - (numRecords -2) * CLUSTERSIZE); // 0 means the result is correct
