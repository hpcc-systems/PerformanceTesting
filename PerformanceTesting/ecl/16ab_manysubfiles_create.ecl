//class=super
//class=create

#DECLARE(defaultNumFiles)
#SET(defaultNumFiles, 2000)
#option('loopMaxEmpty', %defaultNumFiles%+1);

import ^ as root;
import $ as suite;
import suite.perform.files;

import Std.File;

numFiles := #IFDEFINED(root.numFiles, %defaultNumFiles%);
prefix := files.simpleName + '_manysubfiles';
superFileName := prefix + '_super';

rec := RECORD
    unsigned4 fileNumber;
END;

subFileRec := RECORD
    string name;
END;

createSubFile(DATASET(rec) loopInput, unsigned fileNumber) := FUNCTION
    subFileName := prefix + '_sub' + fileNumber;
    contents := DATASET([{fileNumber}], rec);
    writeFile := OUTPUT(contents, , subFileName, OVERWRITE);
    RETURN WHEN(loopInput, writeFile);
END;

subFiles := DATASET(numFiles, TRANSFORM(subFileRec,
    SELF.name := prefix + '_sub' + COUNTER));

SEQUENTIAL(
    IF(File.FileExists(superFileName), File.DeleteSuperFile(superFileName, TRUE)),
    File.CreateSuperFile(superFileName),
    OUTPUT(LOOP(DATASET([], rec), numFiles,
                createSubFile(ROWS(LEFT), COUNTER)), NAMED('CreateSubFiles')),
    File.StartSuperFileTransaction(),
    NOTHOR(APPLY(subFiles, File.AddSuperFile(superFileName, name))),
    File.FinishSuperFileTransaction(),
    OUTPUT(File.GetSuperFileSubCount(superFileName) = numFiles,
           NAMED('CorrectSubFileCount'))
);
