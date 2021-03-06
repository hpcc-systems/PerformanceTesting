//class=memory
//class=parallel
//class=stress
//class=sort

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;
#option ('unlimitedResources', true); // generate all the sorts into a single graph

s(unsigned delta) := FUNCTION
    ds := files.generateSimple(delta);

    RETURN NOFOLD(sort(ds, id3, LOCAL));
END;

ds(unsigned i) := s(i+0x00000000) + s(i+0x10000000) + s(i+0x20000000) + s(i+0x30000000);

///16 Times is too much for thor running on a local machine
dsAll := ds(0);// + ds(0x40000000) + ds(0x80000000) + ds(0xc0000000);

output(COUNT(NOFOLD(dsAll)) = config.simpleRecordCount * 4);
