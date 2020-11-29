Trait {
	#name : #DMTDataExtractor,
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassModelsFrom: aConceptualModel [

	^(aConceptualModel packagemodels flatCollect: [ :eachPackageModel | eachPackageModel classmodels ])
]

{ #category : #ambiguous }
DMTDataExtractor >> extractConceptsFrom: aPackageModel [

	^aPackageModel classmodels collect: [ :aClassModel | aClassModel concept ]
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractHierarchiesFrom: aDMPackageModel [ 

	^(aDMPackageModel classmodels collect: [ :each | each classmodel root ])
]
