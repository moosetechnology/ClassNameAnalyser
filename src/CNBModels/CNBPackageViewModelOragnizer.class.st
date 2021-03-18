Class {
	#name : #CNBPackageViewModelOragnizer,
	#superclass : #Object,
	#instVars : [
		'package',
		'clusterer'
	],
	#category : #CNBModels
}

{ #category : #'instance creation' }
CNBPackageViewModelOragnizer class >> of: aPackageModel [
	^ self new
		package: aPackageModel 
]

{ #category : #'as yet unclassified' }
CNBPackageViewModelOragnizer >> attributeTokensToClassesInside: aPackage [

	aPackage tokenViewModels do: [ :each | each attributeTokenToClasses ]
]

{ #category : #'as yet unclassified' }
CNBPackageViewModelOragnizer >> cluster: aPackageViewModel [ 
	
	^ clusterer organize: aPackageViewModel property: #siblings 
	
]

{ #category : #initialization }
CNBPackageViewModelOragnizer >> initialize [ 
	super initialize.
	
	clusterer := CNBClusterer new
]

{ #category : #initialization }
CNBPackageViewModelOragnizer >> removeEmptyTokens: aPackage [

	aPackage tokenViewModels: (aPackage tokenViewModels removeAllSuchThat: [ :each | each size isZero ])
]

{ #category : #initialization }
CNBPackageViewModelOragnizer >> reset: aPackage [

	self removeEmptyTokens: aPackage.
	self attributeTokensToClassesInside: aPackage.
	^ aPackage 
]
