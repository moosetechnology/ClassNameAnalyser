Trait {
	#name : #CNBTDataExtractor,
	#category : #CNBBuilder
}

{ #category : #extracting }
CNBTDataExtractor >> extractClassModelsFrom: packageModels [
	^ (packageModels
		flatCollect: [ :eachPackageModel | eachPackageModel classModels ])
		asOrderedCollection
]

{ #category : #extracting }
CNBTDataExtractor >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel models flatCollect: [ :eachPackageViewModel |  eachPackageViewModel models flatCollect: #models])
]

{ #category : #extracting }
CNBTDataExtractor >> extractConceptsFrom: aPackageModel [

	^aPackageModel classModels collect: [ :aClassModel | aClassModel suffix ]
]

{ #category : #selecting }
CNBTDataExtractor >> selectBiggestHierarchyOf: aToken using: aCollectioOfRootModels [
	^ (aCollectioOfRootModels detect: [ :aRoot | aRoot concepts includes: aToken ]).
]
