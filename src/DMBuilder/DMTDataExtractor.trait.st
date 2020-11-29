Trait {
	#name : #DMTDataExtractor,
	#category : #DMBuilder
}

{ #category : #ambiguous }
DMTDataExtractor >> extractConceptsFrom: aPackageModel [

	^aPackageModel classmodels collect: [ :aClassModel | aClassModel concept ]
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractHierarchiesFrom: aDMPackageModel [ 
	^(aDMPackageModel classmodels collect: [ :each | each classmodel concept ])
]
