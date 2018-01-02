*DataFrame-Core-Base
closeTo: aCollection

	^ (self - aCollection) inject: true into: [ :accum :each |
		accum and: (each closeTo: 0) ].