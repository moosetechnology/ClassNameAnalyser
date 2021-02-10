Trait {
	#name : #DMTDataExtractor,
	#category : #CNBBuilder
}

{ #category : #extracting }
DMTDataExtractor >> extractClassModelsFrom: packageModels [
	^ (packageModels
		flatCollect: [ :eachPackageModel | eachPackageModel classModels ])
		asOrderedCollection
]

{ #category : #extracting }
DMTDataExtractor >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel models flatCollect: [ :eachPackageViewModel |  eachPackageViewModel models flatCollect: #models])
]

{ #category : #extracting }
DMTDataExtractor >> extractConceptsFrom: aPackageModel [

	^aPackageModel classModels collect: [ :aClassModel | aClassModel suffix ]
]

{ #category : #selecting }
DMTDataExtractor >> selectBiggestHierarchyOf: aConcept using: aCollectioOfRootModels [
	^(aCollectioOfRootModels detect: [ :aRoot | aRoot concepts includes: aConcept ]).
]
