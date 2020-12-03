Trait {
	#name : #DMTDataExtractor,
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassModelsFrom: aConceptualModel [

	^(aConceptualModel packagemodels flatCollect: [ :eachPackageModel | eachPackageModel classmodels ]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel packageViewModels flatCollect: [ :eachPackageViewModel |  eachPackageViewModel conceptViewModels flatCollect: #classViewModels])
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

{ #category : #actions }
DMTDataExtractor >> selectBiggestHierarchyFor: aConcept [
	| biggest rootModels index |
	index := 2.
	rootModels := self extractRootModelsFor: aConcept.
	rootModels notEmpty
		ifTrue: [ biggest := rootModels at: 1 ].
	rootModels size = 1
		ifTrue: [ ^ biggest ].
	[ index <= rootModels size ]
		whileTrue: [ rootModels
				do: [ :aRootModel | 
					aRootModel subclasses size > biggest subclasses size
						ifTrue: [ biggest := aRootModel ].
					index := index + 1 ] ].
	^ biggest
]
