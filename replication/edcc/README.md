# EDCC 24 - replication package

## Files
The content of this replication package is the following:
* *Attribute.m*: class hiding the construction and the analysis of a single attribute.
* *System.m*: class hiding the construction and the analysis of the entire system.
* *visibility_fuzzy_reaoner.m*: functions creating the VFR for single attributes.
* *severity_fuzzy_reasoner.m*: function creating the SFR for the entire approach.
* *comparison.m*: script related to the first experiment contained in the paper.
* *sensitivity.m*: script related to the second experiment contained in the paper.
* *scalability.m*: script related to the third experiment contained in the paper.
* *replication.m*: script collecting the previous three scripts and generating the three CSV files in output containting the data reported in the paper.

## Prerequisites
This software is build using Matlab R2023a, licensed to Universita' della Campania "Luigi Vanvitelli". The tools use the Fuzzy Logic Toolbox v.3.1.

## How to run
To replicate the results of the research:
1. open a terminal and move to the folder containing the source files
2. type `matlab -nodisplay -nosplash -nodesktop`
3. at the Matlab prompt, digit: `replication`


