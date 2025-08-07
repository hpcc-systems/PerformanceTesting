//class=super
//class=create

import $ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;

import Std.File;

rec := RECORD
 unsigned4 id;
END;

numSuperFiles := 10;
numSubFiles := 20;

superNames := DATASET(numSuperFiles, TRANSFORM({string sfname}, SELF.sfname := files.simpleName+'_super' + COUNTER));
subNames := DATASET(numSubFiles, TRANSFORM({string fname}, SELF.fname := files.simpleName+'_sub' + COUNTER));

// Clear and create superfiles
createSuperFiles := NOTHOR(APPLY(superNames,
                     ORDERED(
                              IF(File.FileExists(sfname), File.DeleteSuperFile(sfname));
                              File.CreateSuperFile(sfname);
                       )
                  )
            );

dummyDs := DATASET([], rec);

// Create subfiles, populate each with a single row with the counter as the field value
createSubFilesFunc(DATASET(rec) loopin, unsigned c) := FUNCTION
  ds := DATASET([{c}], rec);
  subname := files.simpleName+'_sub' + c;
  o := OUTPUT(ds, , subname, OVERWRITE);
  RETURN WHEN(loopin, o);
END;
createSubFiles := OUTPUT(LOOP(dummyDs, numSubFiles, createSubFilesFunc(ROWS(LEFT), COUNTER)));

// Add subfiles to superfiles
addSubFiles := NOTHOR(APPLY(superNames,
                     APPLY(subNames,
                            File.AddSuperFile(superNames.sfname, fname)
                          )
                  )
            );

// Add superfiles to a super superfile
ssfname := files.simpleName+'_supersuper';
addSupersToSuperSuper := NOTHOR(APPLY(superNames, File.AddSuperFile(ssfname, sfname)));

ssuperds := DATASET(ssfname, rec, FLAT);
SEQUENTIAL(
 IF(File.FileExists(ssfname), File.DeleteSuperFile(ssfname));
 File.CreateSuperFile(ssfname);
 createSuperFiles;
 createSubFiles;
 addSubFiles;
 addSupersToSuperSuper;
 NOFOLD(OUTPUT(ssuperds));
);
