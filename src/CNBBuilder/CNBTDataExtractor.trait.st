"
I extract data from the ClassNames Distribution.
"
Trait {
	#name : #CNBTDataExtractor,
	#category : #'CNBBuilder-Traits'
}

{ #category : #extracting }
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

{ #category : #extracting }
CNBTDataExtractor >> fatBlobCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isFatBlob ] ]) size		
]

{ #category : #extracting }
CNBTDataExtractor >> homogeneousCasesIn: aCnb [

	^ (aCnb viewModel rootModels select: [ :aRoot | aRoot isMonoToken ]) size		
]

{ #category : #extracting }
CNBTDataExtractor >> intruderCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isIntruder ] ]) size		
]

{ #category : #extracting }
CNBTDataExtractor >> nearlyHomogeneousCasesIn: aCnb [

	^ (aCnb 
		viewModel rootModels select: [ :each | each nearlyHomogeneous ]) size
]

{ #category : #extracting }
CNBTDataExtractor >> scatteredVocabularyCasesIn: aCnb [

	^ (aCnb rootModels select: [ :each | each isScattered ]) size
	
]

{ #category : #selecting }
CNBTDataExtractor >> selectBiggestHierarchyOf: aToken using: rootModels [

	^ (rootModels 
			detect: [ :aRoot | aRoot 
							dominantTokens keys includes: aToken ] ifNone: [ nil ] ).
]

{ #category : #extracting }
CNBTDataExtractor >> snowFlakesCasesIn: aCnb [

	^ (aCnb 
		viewModel 
			tokenModels 
				select: [ :aToken | aToken patterns anySatisfy: [ :aPattern | aPattern isSnowFlakes ] ]) size		
]
