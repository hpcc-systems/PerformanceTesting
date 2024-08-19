//class=memory
//class=distribute
//nohthor
//noroxie

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := DATASET(config.variableRecordCount, format.createParent(COUNTER, config.variableRecordChildren, 0), DISTRIBUTED);

d := distribute(ds, hash32(id3));

output(COUNT(NOFOLD(d)) = config.variableRecordCount);
