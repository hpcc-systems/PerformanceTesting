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

unsigned id := 0 : stored ('id');

    FirstNameRecord := RECORD
        STRING firstName;
    END;

    FirstNames := DATASET([
        {'James'}, {'Mary'}, {'John'}, {'Patricia'}, {'Robert'}, {'Jennifer'}, {'Michael'}, {'Linda'}, 
        {'William'}, {'Elizabeth'}, {'David'}, {'Barbara'}, {'Richard'}, {'Susan'}, {'Joseph'}, {'Jessica'}, 
        {'Thomas'}, {'Sarah'}, {'Charles'}, {'Karen'}, {'Christopher'}, {'Nancy'}, {'Daniel'}, {'Lisa'}, 
        {'Matthew'}, {'Betty'}, {'Anthony'}, {'Margaret'}, {'Mark'}, {'Sandra'}, {'Donald'}, {'Ashley'}, 
        {'Steven'}, {'Kimberly'}, {'Paul'}, {'Emily'}, {'Andrew'}, {'Donna'}, {'Joshua'}, {'Michelle'}, 
        {'Kenneth'}, {'Dorothy'}, {'Kevin'}, {'Carol'}, {'Brian'}, {'Amanda'}, {'George'}, {'Melissa'}, 
        {'Edward'}, {'Deborah'}, {'Ronald'}, {'Stephanie'}, {'Timothy'}, {'Rebecca'}, {'Jason'}, {'Sharon'}, 
        {'Jeffrey'}, {'Laura'}, {'Ryan'}, {'Cynthia'}, {'Jacob'}, {'Kathleen'}, {'Gary'}, {'Amy'}, 
        {'Nicholas'}, {'Shirley'}, {'Eric'}, {'Angela'}, {'Jonathan'}, {'Helen'}, {'Stephen'}, {'Anna'}, 
        {'Larry'}, {'Brenda'}, {'Justin'}, {'Pamela'}, {'Scott'}, {'Nicole'}, {'Brandon'}, {'Emma'}, 
        {'Frank'}, {'Samantha'}, {'Benjamin'}, {'Katherine'}, {'Gregory'}, {'Christine'}, {'Raymond'}, {'Debra'}, 
        {'Samuel'}, {'Rachel'}, {'Patrick'}, {'Catherine'}, {'Alexander'}, {'Carolyn'}, {'Jack'}, {'Janet'}, 
        {'Dennis'}, {'Ruth'}, {'Jerry'}, {'Maria'}
    ], FirstNameRecord);

ServiceOutRecord :=
    RECORD
        unsigned id;
        string name;
    END;

  output(dataset([
                {id, FirstNames[id % 100].firstName}
            ], ServiceOutRecord));

