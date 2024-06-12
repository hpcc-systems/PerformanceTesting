//class=memory
//class=splitter

//Test the performance of a balanced splitter

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

sharedDs := NOFOLD(ds)(id1 != 0);

c1 := COUNT(sharedDs(id1 != 1))+CLUSTERSIZE : global;
c2 := COUNT(sharedDs(id1 != 2))+CLUSTERSIZE : global;

OUTPUT(c1 + c2 - (numRecords) * 2 * CLUSTERSIZE); // 0 means the result is correct
