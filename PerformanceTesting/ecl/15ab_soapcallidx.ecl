/*##############################################################################

    HPCC SYSTEMS software Copyright (C) 2024 HPCC Systems®.

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

//Test soapcall that performs and index lookup

//class=memory
//class=soapcall
//class=roxieserviceaccess

//version persistConnection=false
//version persistConnection=true
//version persistConnection=false,tls=true
//version persistConnection=true,tls=true

import $ as suite;

import ^ as root;
usePersist := #IFDEFINED(root.persistConnection, false);
useTls := #IFDEFINED(root.tls, false);

string targetIP := '.' : stored('targetIP');
string roxiePort := '9876' : stored('roxiePort');
string roxieTlsPort := '19876' : stored('roxieTlsPort');

string protocol := IF(useTls, 'https', 'http');
string port := IF(useTls, roxieTlsPort, roxiePort);
string targetURL := protocol + '://' + targetIP + ':' + port;

ServiceOutRecord :=
    RECORD
        unsigned id2;
        unsigned id3;
    END;

import suite.perform.config;
import suite.perform.format;
import suite.perform.files;
import suite.perform.util;

approxRecords := 20000;
unsigned scale := config.simpleRecordCount / approxRecords;
unsigned numRecords := config.simpleRecordCount DIV scale;
ds := DATASET(numRecords, format.createSimple(1 + ((COUNTER-1) * scale)), DISTRIBUTED);

// simple dataset->dataset form
soapcallResult := SOAPCALL(ds, targetURL,'performsoapserviceidx', { unsigned searchId := id1 }, DATASET(ServiceOutRecord), PERSIST(usePersist), PARALLEL(1));

output(count(nocombine(soapcallResult))-numRecords);

