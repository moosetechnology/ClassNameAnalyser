Trait {
	#name : #DMTDataExtractor,
	#category : #CNBBuilder
}

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassModelsFrom: packageModels [
	^ (packageModels
		flatCollect: [ :eachPackageModel | eachPackageModel classModels ])
		asOrderedCollection
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel models flatCollect: [ :eachPackageViewModel |  eachPackageViewModel models flatCollect: #models])
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractConceptsFrom: aPackageModel [

	^aPackageModel classModels collect: [ :aClassModel | aClassModel concept ]
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> selectBiggestHierarchyOf: aConcept using: aCollectioOfRootModels [
	^(aCollectioOfRootModels detect: [ :aRoot | aRoot concepts includes: aConcept ]).
]
