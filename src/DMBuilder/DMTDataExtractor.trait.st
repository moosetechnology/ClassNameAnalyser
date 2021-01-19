Trait {
	#name : #DMTDataExtractor,
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMTDataExtractor >> extractClassViewModelsFrom: aViewModel [

	^(aViewModel conceptViewModels flatCollect: [ :eachPackageViewModel |  eachPackageViewModel conceptViewModels flatCollect: #conceptViewModels])
]
