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

{ #category : #accessing }
DMOrderAttributor >> orderFromSmallest [ 
	^orderFromSmallest 
]

{ #category : #accessing }
DMOrderAttributor >> orderFromSmallest: aBoolean [
	orderFromSmallest := aBoolean
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








	^aViewModel 
]

{ #category : #action }
DMOrderAttributor >> setOrderFromSmallest: aViewModel [
			
	| viewModel allPackageVMs orderedPackageVMs conceptVMs classVMs 
				allPackageVMSizes 	allClassVMSizes |
	viewModel := DMViewModel new.
	viewModel := aViewModel deepCopy.
	allPackageVMs := viewModel packageViewModels.
	allPackageVMSizes := ((allPackageVMs collect: [ :aPackageVM | aPackageVM size ]) asSet).
	orderedPackageVMs := (allPackageVMSizes asSortedCollection flatCollect: [ :aPackageVMSize | 
			allPackageVMs select: [ :aPackageVM | aPackageVM size == aPackageVMSize ]
			 ]).
		viewModel packageViewModels: orderedPackageVMs.
	
	viewModel packageViewModels collect: [ :aPackageVVM | | orderedConceptVMs allConceptVMSizes |
		allConceptVMSizes := (aPackageVVM conceptViewModels collect: [ :aConceptVM |aConceptVM size ]) 			asSet.
		orderedConceptVMs := (allConceptVMSizes asSortedCollection flatCollect: [ :aConceptVMSize |
			aPackageVVM conceptViewModels select: [ :aConceptVM | aConceptVM size == aConceptVMSize ]	
			 ]).
		aPackageVVM conceptViewModels: orderedConceptVMs.		
		 ].

	^viewModel 
]
