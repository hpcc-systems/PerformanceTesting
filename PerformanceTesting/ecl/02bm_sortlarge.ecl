//class=memory
//class=sort

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := DATASET(config.largeRecordCount, format.createParent(COUNTER, config.largeRecordChildren, 0), DISTRIBUTED);

s1 := sort(ds, id3, SKEW(0.1));
s2 := SORTED(NOFOLD(s1), id3, local, assert);

output(COUNT(NOFOLD(s2)) = config.largeRecordCount);
