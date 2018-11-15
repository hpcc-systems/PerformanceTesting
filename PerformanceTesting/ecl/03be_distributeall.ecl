//class=memory
//class=distribute

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := files.generateSimple();

d := distribute(ds, ALL);

output(COUNT(NOFOLD(d)) = config.simpleRecordCount*CLUSTERSIZE);
