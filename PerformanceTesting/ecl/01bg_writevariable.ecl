//class=disk
//class=diskwrite
//class=setup

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

ds := DATASET(config.variableRecordCount, format.createParent(COUNTER, config.variableRecordChildren, 0), DISTRIBUTED);
OUTPUT(ds,,files.simpleName+'_variable',overwrite,compressed);
