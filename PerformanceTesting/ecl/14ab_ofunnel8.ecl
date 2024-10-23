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

result := (+)(ds(0), ds(1), ds(2), ds(3), ds(4), ds(5), ds(6), ds(7), ordered);
c := COUNT(NOFOLD(result));
output(c - 8 * numRecords * CLUSTERSIZE);
