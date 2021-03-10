"
I am the package visualization model
"
Class {
	#name : #CNBPackageViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'size',
		'tokenViewModels',
		'model'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBPackageViewModel class >> of: aModel with: tokenModels [
	^ (self new
		model: aModel;
		tokenViewModels: tokenModels) create

]

{ #category : #operations }
CNBPackageViewModel >> create [

	self 
		name: model name;
		size: (tokenViewModels flatCollect: #classViewModels) size;
		color: self defaultColor;
		originalColor: self defaultColor.

]

{ #category : #accessing }
CNBPackageViewModel >> model [

	^ model
]

{ #category : #accessing }
CNBPackageViewModel >> model: aModel [

	model := aModel
]

{ #category : #accessing }
CNBPackageViewModel >> models [

	^ tokenViewModels 
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedAscending [

	^ tokenViewModels 
			sorted: #size ascending
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedByColor [

	 ^ CNBBuilder sort: tokenViewModels
]

{ #category : #accessing }
CNBPackageViewModel >> modelsOrderedDescending [

	^ tokenViewModels 
				sorted: #size descending
]

{ #category : #'events-processing' }
CNBPackageViewModel >> processEvent: evt [

	Smalltalk tools browser openOnPackage:(RPackageOrganizer default packageNamed: name) 
]

{ #category : #accessing }
CNBPackageViewModel >> size [

	^ size
]

{ #category : #accessing }
CNBPackageViewModel >> size: aNumber [

	size := aNumber 
]

{ #category : #accessing }
CNBPackageViewModel >> tokenViewModels [

	^ tokenViewModels
]

{ #category : #accessing }
CNBPackageViewModel >> tokenViewModels: tokenModels [

	tokenViewModels := tokenModels
]
