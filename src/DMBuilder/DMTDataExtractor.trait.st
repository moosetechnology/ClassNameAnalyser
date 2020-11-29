Trait {
	#name : #DMTDataExtractor,
	#category : #DMBuilder
}

{ #category : #ambiguous }
DMTDataExtractor >> extractConceptsFrom: aPackageModel [

	^aPackageModel classmodels collect: [ :aClassModel | aClassModel concept ]
]
