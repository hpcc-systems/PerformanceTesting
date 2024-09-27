/*##############################################################################

    HPCC SYSTEMS software Copyright (C) 2012 HPCC Systems®.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
############################################################################## */

//nohthor
//nothor
//publish

//class=index
//class=keyedjoin

#onwarning (4522, ignore);

import $.^ as suite;
import suite.perform.config;
import suite.perform.format;
import suite.perform.files;
import suite.perform.util;

unsigned searchId := 0 : stored('searchId');

matches := files.manyIndex123(
            id1a = util.byte(searchId, 0) AND 
            id1b = util.byte(searchId, 1) AND 
            id1c = util.byte(searchId, 2) AND 
            id1d = util.byte(searchId, 3) AND 
            id1e = util.byte(searchId, 4) AND 
            id1f = util.byte(searchId, 5) AND 
            id1g = util.byte(searchId, 6) AND 
            id1h = util.byte(searchId, 7)); 

ServiceOutRecord :=
    RECORD
        unsigned id2;
        unsigned id3;
    END;

output(PROJECT(matches, TRANSFORM(ServiceOutRecord, SELF := LEFT)));

