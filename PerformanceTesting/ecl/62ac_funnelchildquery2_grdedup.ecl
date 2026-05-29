//class=memory
//class=quick
//class=create

import ^ as root;
import $ as suite;
import suite.perform.config, suite.perform.files;

timeActivities := #IFDEFINED(root.timeActivities, true);

#option('timeActivities', timeActivities);

import $ as suite;
import suite.perform.config;
import suite.perform.files;
import suite.perform.format;

idRec := { unsigned id };
simpleRec := format.simpleRec;

ds := files.generateSimpleScaled(0, 100);

mkId(unsigned id) := TRANSFORM(idRec, SELF.id := id);
mkDs(unsigned id) := DATASET([mkId(id)]);

childQuery(simpleRec l) := FUNCTION
    a := mkDs(l.id1);
    b := mkDs(l.id2);
    c := NOCOMBINE(a) & NOCOMBINE(b);
    d := SORT(c, id);
    e := GROUP(d, id);
    f := DEDUP(e, id);
    RETURN GROUP(f);
END;

complexRec := { unsigned id, DATASET(idRec) children; };

complexRec doProcessing(simpleRec l) := TRANSFORM
    SELF.id := l.id3;
    SELF.children := childQuery(l);
END;

p := PROJECT(NOCOMBINE(ds), doProcessing(LEFT));

cnt := COUNT(NOFOLD(p));
OUTPUT(cnt - config.simpleRecordCount DIV 100);
