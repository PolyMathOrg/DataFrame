as yet unclassified
showWithGlamour

	| table |

	table := FTTableMorph new
		extent: 650@500.
		
	table addColumn: ((FTColumn id: '#') width: 40).
	
	self columnNames do: [ :colName |
		table addColumn: (FTColumn id: colName) ].
	
	table
		intercellSpacing: 1;
		dataSource: (DataFrameFTData elements: self);
		selectRowIndex: 1;
		showFirstRowSelection;
		onAnnouncement: FTSelectionChanged 
			do: [ :ann | ('rows selected: ', (ann newSelectedRowIndexes asString)) crLog ];
		onAnnouncement: FTStrongSelectionChanged 
			do: [ :ann | ('double-click on row: ', (ann selectedRowIndex asString)) crLog ];
		beMultipleSelection;
		yourself.
		
	^ table openInWindowLabeled: 'a DataFrame'.