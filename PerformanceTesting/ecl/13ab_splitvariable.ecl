//class=memory
//class=sort

//nohthor - hthor does not have splitters
//noroxie - also likely to exeed the roxie memory limits since all rows will be buffered

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := DATASET(config.variableRecordCount, format.createParent(COUNTER, config.variableRecordChildren, 0), DISTRIBUTED);

ds2 := (+)(ds, ds, ordered);

output(COUNT(NOFOLD(ds2)) = config.variableRecordCount * 2);
