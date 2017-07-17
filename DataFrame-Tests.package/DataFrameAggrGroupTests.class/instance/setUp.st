initialization
setUp

	df := DataFrame fromRows:
		#((16.99 1.01 'Female' 'No' 'Sun' 'Dinner' 2)
		  (10.34 1.66 'Male' 'No' 'Sun' 'Dinner' 3)
		  (21.01 3.5 'Male' 'No' 'Sun' 'Dinner' 3)
		  (23.68 3.31 'Male' 'No' 'Sun' 'Dinner' 2)
		  (24.59 3.61 'Female' 'No' 'Sun' 'Dinner' 4)).
		
	df columnNames: #('total_bill' 'tip' 'sex' 'smoker' 'day' 'time' 'size').