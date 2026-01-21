//class=disk
//class=quick
//class=diskread

//noroxie - almost certainly will cause timeout issues due to sending remote rows.  Should revisit.

#option ('hthorMemoryLimit', '4000');
import ^ as root;
import $ as suite;
import suite.perform.config;
import suite.perform.files;
import suite.perform.format;

ds := DATASET(files.simpleName+'_vlarge', format.grandParentRec, FLAT);
OUTPUT(COUNT(NOFOLD(ds)) = config.vlargeRecordCount);
