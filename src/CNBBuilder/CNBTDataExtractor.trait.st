Trait {
	#name : #CNBTDataExtractor,
	#category : #CNBBuilder
}

{ #category : #'as yet unclassified' }
CNBTDataExtractor >> confettiCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isConfetti ] ]) size		
]

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

{ #category : #'as yet unclassified' }
CNBTDataExtractor >> fatBlobCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isFatBlob ] ]) size		
]

{ #category : #'as yet unclassified' }
CNBTDataExtractor >> homogeneityBreakerCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isHomogeneityBreaker ] ]) size		
]

{ #category : #'as yet unclassified' }
CNBTDataExtractor >> homogeneousCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isHomogeneous ] ]) size		
]

{ #category : #'as yet unclassified' }
CNBTDataExtractor >> intruderCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isIntruder ] ]) size		
]

{ #category : #'as yet unclassified' }
CNBTDataExtractor >> scatteredVocabularyCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isFatBlob ] ]) size		
]

{ #category : #selecting }
CNBTDataExtractor >> selectBiggestHierarchyOf: aToken using: rootModels [

	^ (rootModels 
			detect: [ :aRoot | aRoot 
							dominantTokens keys includes: aToken ] ifNone: [ nil ] ).
]

{ #category : #'as yet unclassified' }
CNBTDataExtractor >> snowFlakesCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isSnowFlakes ] ]) size		
]
