Class {
	#name : #TestCsvStrings,
	#superclass : #Object,
	#category : #'DataFrame-IO-Tests'
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
