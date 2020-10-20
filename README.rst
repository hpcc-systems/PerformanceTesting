..  HPCC SYSTEMS software Copyright (C) 2013 HPCC Systems.
..
..  Licensed under the Apache License, Version 2.0 (the "License");
..  you may not use this file except in compliance with the License.
..  You may obtain a copy of the License at
..
..     http://www.apache.org/licenses/LICENSE-2.0
..
..  Unless required by applicable law or agreed to in writing, software
..  distributed under the License is distributed on an "AS IS" BASIS,
..  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
..  See the License for the specific language governing permissions and
..  limitations under the License.

PerformanceTesting
==================

This folder contains a set of ECL queries that are designed to test the performance of the HPCC system,
and allow changes in speed and memory usage to be tracked over time.

A Python3 script is available within the HPCC Systems platform code for easily executing these tests and
verifying that they perform as expected.  To run the regression suite with the script, clone the source
code using git and change directory to the script's location:

#: git clone https://github.com/hpcc-systems/HPCC-Platform
#: cd HPCC-Platform/testing/regress

Several scripts require data to work with.  Execute all setup scripts:

#: ./ecl-test setup --timeout -1 --suiteDir <bundle-directory> --server <ip-or-name> --target <cluster>

Now you can run the tests:

#: ./ecl-test run --timeout -1 --suiteDir <bundle-directory> --server <ip-or-name> --target <cluster>

In the above commands, the <bracketed> items mean:

<bundle-directory>: The directory containing the ecl/ subdirectory that contains the test scripts
(e.g. the PerformanceTesting subdirectory).  If not provided, this will default to the current directory.

<ip-or-name>: The IP address or name of the ECL Watch page of the cluster you are testing.  If not provided,
it will default to "localhost".

<cluster>: The execution engine to test (e.g. hthor, thor, roxie)

Each of the tests in the regression suite is assigned to one or more classes.  This allows subsets of the
regression tests to be included or excluded for a particular run.  Use the --runclasss argument to specify
classes; full details of the different classes is included in TestSummary.rst.

Further options for the test script can be found with:

#: ./ecl-test --help

Currently the last query (summary01) generates a result that when viewed with the new eclwatch
produces a table of job v. date giving a summary of the time taken and memory consumed.

