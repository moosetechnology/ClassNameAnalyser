Class {
	#name : #DMOrderAttributor,
	#superclass : #Object,
	#instVars : [
		'orderFromBiggest',
		'orderFromSmallest'
	],
	#category : #DMClassNameBlueprint
}

{ #category : #initialization }
DMOrderAttributor >> initialize [ 
	
	super initialize.
	orderFromBiggest := false.
	orderFromSmallest := false.
]

{ #category : #accessing }
DMOrderAttributor >> orderFromBiggest [ 
	^orderFromBiggest 
]

{ #category : #accessing }
DMOrderAttributor >> orderFromBiggest: aBoolean [
	orderFromBiggest := aBoolean 
]

{ #category : #action }
DMOrderAttributor >> orderFromBiggestConceptVMs: aViewModel [

	(aViewModel packageViewModels collect: [ :aPackageVVM | | orderedConceptVMs allConceptVMSizes |
		allConceptVMSizes := (aPackageVVM conceptViewModels collect: [ :aConceptVM |aConceptVM size ]) 			asSet. 
		orderedConceptVMs := ((allConceptVMSizes asSortedCollection) asOrderedCollection reversed 	flatCollect: [ :aConceptVMSize |
			aPackageVVM conceptViewModels select: [ :aConceptVM | aConceptVM size == aConceptVMSize ]	
			 ]).
		aPackageVVM conceptViewModels: orderedConceptVMs.		
		 ]).
	^ aViewModel 
]

{ #category : #action }
DMOrderAttributor >> orderFromBiggestPackageVMs: aViewModel [

	| allPackageVMs allPackageVMSizes orderedPackageVMs |
	allPackageVMs := aViewModel packageViewModels.
	allPackageVMSizes := ((allPackageVMs collect: [ :aPackageVM | aPackageVM size ]) asSet).
	orderedPackageVMs := ( (allPackageVMSizes asSortedCollection) asOrderedCollection reversed flatCollect: [ :aPackageVMSize | 
			allPackageVMs select: [ :aPackageVM | aPackageVM size == aPackageVMSize ]
			 ]).
		aViewModel packageViewModels: orderedPackageVMs.
	^aViewModel 

]

{ #category : #accessing }
DMOrderAttributor >> orderFromSmallest [ 
	^orderFromSmallest 
]

{ #category : #accessing }
DMOrderAttributor >> orderFromSmallest: aBoolean [
	orderFromSmallest := aBoolean
]

{ #category : #action }
DMOrderAttributor >> orderFromSmallestConceptVMs: aViewModel [

	
	(aViewModel packageViewModels collect: [ :aPackageVVM | | orderedConceptVMs allConceptVMSizes |
		allConceptVMSizes := (aPackageVVM conceptViewModels collect: [ :aConceptVM |aConceptVM size ]) 			asSet. 
		orderedConceptVMs := (allConceptVMSizes asSortedCollection flatCollect: [ :aConceptVMSize |
			aPackageVVM conceptViewModels select: [ :aConceptVM | aConceptVM size == aConceptVMSize ]	
			 ]).
		aPackageVVM conceptViewModels: orderedConceptVMs.		
		 ]).
	^ aViewModel 
]

{ #category : #action }
DMOrderAttributor >> orderFromSmallestPackageVMs: aViewModel [

	| allPackageVMs allPackageVMSizes orderedPackageVMs |
	allPackageVMs := aViewModel packageViewModels.
	allPackageVMSizes := ((allPackageVMs collect: [ :aPackageVM | aPackageVM size ]) asSet).
	orderedPackageVMs := (allPackageVMSizes asSortedCollection flatCollect: [ :aPackageVMSize | 
			allPackageVMs select: [ :aPackageVM | aPackageVM size == aPackageVMSize ]
			 ]).
		aViewModel packageViewModels: orderedPackageVMs.
	^aViewModel 
]

{ #category : #action }
DMOrderAttributor >> setOrder: aViewModel [

	(orderFromBiggest)
		ifTrue: [ ^ self setOrderFromBiggest: aViewModel  ].
	
	(orderFromSmallest)
		ifTrue: [ ^ self setOrderFromSmallest: aViewModel  ].
		
	^aViewModel 
]

{ #category : #action }
DMOrderAttributor >> setOrderFromBiggest: aViewModel [

	| viewModel |
	viewModel := DMViewModel new.
	viewModel := aViewModel deepCopy.
	viewModel := self orderFromBiggestPackageVMs: viewModel.
	viewModel := self orderFromBiggestConceptVMs: viewModel.
	^viewModel 
]

{ #category : #action }
DMOrderAttributor >> setOrderFromSmallest: aViewModel [
			
	| viewModel |
	viewModel := DMViewModel new.
	viewModel := aViewModel deepCopy.
	viewModel := self orderFromSmallestPackageVMs: viewModel.
	viewModel := self orderFromSmallestConceptVMs: viewModel.	
	^viewModel 
]
