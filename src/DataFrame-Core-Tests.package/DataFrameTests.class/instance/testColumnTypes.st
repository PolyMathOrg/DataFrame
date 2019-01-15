tests
testColumnTypes

	| expected actual |

	"Note: 0.1 class will be BoxFloat64 on Pharo32 and SmallFloat64 on Pharo64"
	expected := { ByteString . 0.1 class . Boolean }.
	actual := df columnTypes.
	
	self assert: actual equals: expected.