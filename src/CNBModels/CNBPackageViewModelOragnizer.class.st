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
CNBPackageViewModelOragnizer >> cluster: aPackageViewModel [ 
	
	^ clusterer organize: aPackageViewModel property: #siblings 
	
]

{ #category : #initialization }
CNBPackageViewModelOragnizer >> initialize [ 
	super initialize.
	
	clusterer := CNBClusterer new
]
