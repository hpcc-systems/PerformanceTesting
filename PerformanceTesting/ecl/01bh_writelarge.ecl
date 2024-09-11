//class=disk
//class=diskwrite
//class=setup

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := DATASET(config.largeRecordCount, format.createParent(COUNTER, config.largeRecordChildren + COUNTER, 0), DISTRIBUTED);
OUTPUT(ds,,files.simpleName+'_large',overwrite,compressed);
