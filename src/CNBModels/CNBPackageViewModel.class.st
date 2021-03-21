"
I am the package visualization model
"
Class {
	#name : #CNBPackageViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'size',
		'tokenViewModels',
		'model',
		'packageOrganizer'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBPackageViewModel class >> of: aModel with: tokenModels [

	^ (self new
		model: aModel;
		tokenViewModels: tokenModels) create

]

{ #category : #accessing }
CNBPackageViewModel >> classViewModels [ 

	^ (tokenViewModels flatCollect: [ :each | each classViewModels ]) asSet
]

{ #category : #accessing }
CNBPackageViewModel >> classes [ 

	^ self classViewModels 
]

{ #category : #'public layout' }
CNBPackageViewModel >> cluster [ 

	^ packageOrganizer cluster: self	
	
]

{ #category : #operations }
CNBPackageViewModel >> create [

	self 
		name: model name;
		size: (tokenViewModels flatCollect: #classViewModels) size;
		color: self defaultColor;
		originalColor: self defaultColor.
		

]

{ #category : #testing }
CNBPackageViewModel >> hasScatteredVocabularyInside [ 

	^ (tokenViewModels 
			select: [ :each | 
				each pattern isNotNil and: [ each pattern 
					isScatteredVocabulary ] ]) isNotEmpty 
]

{ #category : #initialization }
CNBPackageViewModel >> initialize [ 
	super initialize.
	
	packageOrganizer := CNBPackageViewModelOragnizer new
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
CNBPackageViewModel >> modelsOrderedByColor [

	
	^ CNBBuilder sort: self tokenViewModels


]

{ #category : #'events-processing' }
CNBPackageViewModel >> processEvent: evt [

	"Smalltalk tools browser openOnPackage:(RPackageOrganizer default packageNamed: name) "
	self inspect
]

{ #category : #initialization }
CNBPackageViewModel >> reset [ 

	^ packageOrganizer reset: self
]

{ #category : #accessing }
CNBPackageViewModel >> roots [

	^ (tokenViewModels collect: [ :each | each root ]) asSet
]

{ #category : #'as yet unclassified' }
CNBPackageViewModel >> scatteredRoots [ 

	^ (self roots select: [ :each | each hasScatteredVocabularyInside: self ])
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

{ #category : #accessing }
CNBPackageViewModel >> tokens [ 
	
	^ self tokenViewModels 
]

{ #category : #'as yet unclassified' }
CNBPackageViewModel >> tokensOf: aRootName [
	
	^ (tokenViewModels select: [ :each | each root name = aRootName ])
]
