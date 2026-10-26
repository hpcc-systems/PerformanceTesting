//class=super

import $ as suite;
import suite.perform.files;

import Std.File;

prefix := files.simpleName + '_manysubfiles';
superFileName := prefix + '_super';

SEQUENTIAL(
    File.DeleteSuperFile(superFileName, TRUE),
    OUTPUT(TRUE, NAMED('Deleted'))
);