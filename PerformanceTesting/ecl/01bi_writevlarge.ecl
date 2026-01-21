//class=disk
//class=diskwrite
//class=setup

#option ('hthorMemoryLimit', '4000');
#option ('hthorDiskWriteSizeLimit', 100000000000);

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := DATASET(config.vlargeRecordCount, format.createGrandParent(COUNTER, 1000 + COUNTER, 900 + COUNTER), DISTRIBUTED);
OUTPUT(ds,,files.simpleName+'_vlarge',overwrite,compressed);
