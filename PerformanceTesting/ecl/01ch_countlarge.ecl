//class=disk
//class=quick
//class=diskread

import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;
import suite.perform.format;

ds := DATASET(files.simpleName+'_large', format.parentRec, FLAT);
OUTPUT(COUNT(NOFOLD(ds)) = config.largeRecordCount);
