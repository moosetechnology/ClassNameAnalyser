Trait {
	#name : #CNBTDataExtractor,
	#category : #CNBBuilder
}

{ #category : #extracting }
CNBTDataExtractor >> extractClassModelsFrom: packageModels [

	^ (packageModels
			flatCollect: [ :eachPackageModel | eachPackageModel classModels ]) asOrderedCollection
]

{ #category : #extracting }
CNBTDataExtractor >> extractClassViewModelsFrom: aViewModel [

	^ (aViewModel 
			models 
				flatCollect: [ :eachPackageViewModel |  eachPackageViewModel models flatCollect: #models])
]

{ #category : #extracting }
CNBTDataExtractor >> extractTokensFrom: aPackageModel [

	^ aPackageModel 
			classModels 
				collect: [ :aClassModel | aClassModel token ]
]

{ #category : #selecting }
CNBTDataExtractor >> selectBiggestHierarchyOf: aToken using: rootModels [

	^ (rootModels 
			detect: [ :aRoot | aRoot 
							dominantTokens keys includes: aToken ] ifNone: [ nil ] ).
]
