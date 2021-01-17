Trait {
	#name : #DMTDataExtractor,
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractAllHierarchiesFrom: aCollectionofPackageModels [

	^(aCollectionofPackageModels collect: [ :eachPackageModel | self extractHierarchiesFrom: eachPackageModel ])
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractBiggestClassDepthFrom: classModels [
	
	 ^(classModels collect: #level) detectMax: [ :each | each ]
	
	

]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassModelsFrom: aConceptualModel [

	^(aConceptualModel packageModels flatCollect: [ :eachPackageModel | eachPackageModel classmodels ]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel packageModels flatCollect: [ :eachPackageViewModel |  eachPackageViewModel packageModels flatCollect: #packageModels])
]

{ #category : #ambiguous }
DMTDataExtractor >> extractConceptsFrom: aPackageModel [

	^aPackageModel classmodels collect: [ :aClassModel | aClassModel concept ]
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractHierarchiesFrom: aDMPackageModel [ 

	^(aDMPackageModel classmodels collect: [ :each | each classmodel root ])
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractRootModelsFor: aConcept [
	| rootModels |
	rootModels := OrderedCollection new.
	self class rootmodels 
	collect: [ :aRootModel | 
		(aRootModel concepts includes: aConcept)
		ifTrue:[ rootModels add: aRootModel  ]].
	^rootModels 
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractRootModelsFrom: aCollectionOfRM dominatedBy: aConcept [

	^aCollectionOfRM select: [ :aRM | aRM dominantSuffix key = aConcept ]
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractSmallestClassDepthFrom: classModels [

	^(classModels collect: #level) detectMin: [ :each | each ]
	

]
