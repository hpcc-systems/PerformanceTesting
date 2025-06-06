//class=memory
//class=funnel

//Test the performance of a ordered concat

import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;

numRecords := 20000000;

r := RECORD
    UNSIGNED id1;
END;

r createSimple(unsigned8 c) := TRANSFORM
    SELF.id1 := c;
END;

ds(unsigned i)  := DATASET(numRecords, createSimple(COUNTER+i), LOCAL);

result := (+)(ds(0), ds(1), unordered);
c := COUNT(NOFOLD(result));
output(c - 2 * numRecords * CLUSTERSIZE);
