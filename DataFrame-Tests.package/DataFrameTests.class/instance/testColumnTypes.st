tests
testColumnTypes

	| expected actual |

	expected := { ByteString . BoxedFloat64 . Boolean }.
	actual := df columnTypes.
	
	self assert: actual equals: expected.