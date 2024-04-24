Class {
	#name : #TestCsvStrings,
	#superclass : #Object,
	#category : #'DataFrame-IO-Tests-Core'
}

{ #category : #running }
TestCsvStrings class >> commaCsvString [
	^ ',temperature,precipitation,type
1:10 am,2.4,true,rain
1:30 am,0.5,true,rain
1:50 am,-1.2,true,snow
2:10 am,-2.3,false,-
2:30 am,3.2,true,rain
'
]

{ #category : #running }
TestCsvStrings class >> commaCsvWithoutRowNameString [
	^ 'temperature,precipitation,type
2.4,true,rain
0.5,true,rain
-1.2,true,snow
-2.3,false,-
3.2,true,rain
'
]

{ #category : #running }
TestCsvStrings class >> commaQuoteCsvString [
	^ '"","temperature","precipitation","type"
"1:10 am","2.4","true","rain"
"1:30 am","0.5","true","rain"
"1:50 am","-1.2","true","snow"
"2:10 am","-2.3","false","-"
"2:30 am","3.2","true","rain"
'
]

{ #category : #running }
TestCsvStrings class >> commaQuoteCsvStringWithoutColumnNames [

	^ '"1:10 am","2.4","true","rain"
"1:30 am","0.5","true","rain"
"1:50 am","-1.2","true","snow"
"2:10 am","-2.3","false","-"
"2:30 am","3.2","true","rain"
'
]

{ #category : #running }
TestCsvStrings class >> commaQuoteCsvStringWithoutRowNames [

	^ '"temperature","precipitation","type"
"2.4","true","rain"
"0.5","true","rain"
"-1.2","true","snow"
"-2.3","false","-"
"3.2","true","rain"
'
]

{ #category : #running }
TestCsvStrings class >> commaQuoteCsvStringWithoutRowNamesWithoutColumnNames [

	^ '"2.4","true","rain"
"0.5","true","rain"
"-1.2","true","snow"
"-2.3","false","-"
"3.2","true","rain"
'
]

{ #category : #running }
TestCsvStrings class >> dollarSignCsvString [

	^ 'Given$a$text$file$of$many$lines,$where$fields$within$a$line$
are$delineated$by$a$single$''dollar''$character,$write$a$program
that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$
column$are$separated$by$at$least$one$space.
Further,$allow$for$each$word$in$a$column$to$be$either$left$
justified,$right$justified,$or$center$justified$within$its$column.'
]

{ #category : #running }
TestCsvStrings class >> emptyCsvString [
	^ ''
]

{ #category : #running }
TestCsvStrings class >> tabCsvString [
	^ '	temperature	precipitation	type
1:10 am	2.4	true	rain
1:30 am	0.5	true	rain
1:50 am	-1.2	true	snow
2:10 am	-2.3	false	-
2:30 am	3.2	true	rain
'
]

{ #category : #running }
TestCsvStrings class >> tabQuoteCsvString [
	^ '""	"temperature"	"precipitation"	"type"
"1:10 am"	"2.4"	"true"	"rain"
"1:30 am"	"0.5"	"true"	"rain"
"1:50 am"	"-1.2"	"true"	"snow"
"2:10 am"	"-2.3"	"false"	"-"
"2:30 am"	"3.2"	"true"	"rain"
'
]
