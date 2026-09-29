//class=super

import ^ as root;
import $ as suite;
import suite.perform.files;

numReadGraphs := #IFDEFINED(root.numReadGraphs, 4);
prefix := files.simpleName + '_manysubfiles';
superFileName := prefix + '_super';

rec := RECORD
    unsigned4 fileNumber;
END;

#declare(readNumber)
#set(readNumber, 1)
ORDERED(
    #loop
        OUTPUT(COUNT(NOFOLD(DATASET(superFileName + ('read' + (string)%readNumber%)[1..NOFOLD(0)], rec, FLAT))),
               NAMED('RecordCount' + (string)%readNumber%));
        OUTPUT(COUNT(NOFOLD(DATASET([{%readNumber%}], rec))),
               NAMED('InlineCount' + (string)%readNumber%));
        #set(readNumber, %readNumber% + 1)
        #if (%readNumber% > numReadGraphs)
            #break
        #end
    #end
);
