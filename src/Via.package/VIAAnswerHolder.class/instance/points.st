as yet unclassified
points
	self isUnchecked ifTrue: [^0].
	
	^points ifNil: [
		"OPTIONAL: Mit /correctionCount gewichten"
		taskBrick maxPoints * (correctness/100)]