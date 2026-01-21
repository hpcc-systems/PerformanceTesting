//class=memory
//class=distribute
//nohthor
//noroxie

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := DATASET(config.vlargeRecordCount, format.createGrandParent(COUNTER, 1000 + COUNTER, 900 + COUNTER), DISTRIBUTED);

d := distribute(ds, hash32(id));

output(COUNT(NOFOLD(d)) = config.vlargeRecordCount);
