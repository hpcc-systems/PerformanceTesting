//class=index
//class=keyedjoin

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;
import suite.perform.util;

unsigned scale := IF(config.smokeTest, 0x10000, 0x100);
ds := DATASET(config.simpleRecordCount DIV scale, format.createSimple(1 + ((COUNTER-1) * scale)), DISTRIBUTED);

j := JOIN(ds, files.manyIndex123,
            RIGHT.id1a = util.byte(LEFT.id1, 0) AND 
            RIGHT.id1b = util.byte(LEFT.id1, 1) AND 
            RIGHT.id1c = util.byte(LEFT.id1, 2) AND 
            RIGHT.id1d = util.byte(LEFT.id1, 3) AND 
            RIGHT.id1e = util.byte(LEFT.id1, 4) AND 
            RIGHT.id1f = util.byte(LEFT.id1, 5) AND 
            RIGHT.id1g = util.byte(LEFT.id1, 6),
            TRANSFORM(LEFT), LIMIT(255, TRANSFORM(format.simpleRec, SELF := []))); 
cnt := COUNT(NOFOLD(j));

// 255 matches from 1st record, the rest return 1 limit transform rec. each
OUTPUT(cnt = 255 + (config.simpleRecordCount DIV scale)-1);
