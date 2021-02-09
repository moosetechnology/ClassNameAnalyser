"
I am the package visualization model
"
Class {
	#name : #DMPackageViewModel,
	#superclass : #DMModel,
	#instVars : [
		'suffixViewModels',
		'size',
		'color',
		'border'
	],
	#category : #CNBModels
}

{ #category : #accessing }
DMPackageViewModel >> border [
	^border color: Color black;yourself
]

{ #category : #accessing }
DMPackageViewModel >> borderColor [ 
	^Color black
]

{ #category : #accessing }
DMPackageViewModel >> color [ 
	^Color white darker
]

{ #category : #initialization }
DMPackageViewModel >> createBox [ 
	| packageBox  |
		
	packageBox := RSComposite new 
				model: self;
				color: self color;
				popupText: name;  
				withBorder; 
				border: self border.
	
	^packageBox 
]

{ #category : #initialization }
DMPackageViewModel >> initialize [
	super initialize.
	border := RSBorder new
]

{ #category : #testing }
DMPackageViewModel >> isPackageViewModel [
	^true
]

{ #category : #accessing }
DMPackageViewModel >> models [
	^suffixViewModels 
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedAscending [
	^ suffixViewModels sorted: #size ascending
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedByColor [
	^DMBuilder sort: suffixViewModels
]

{ #category : #'as yet unclassified' }
DMPackageViewModel >> modelsOrderedDescending [

	^ suffixViewModels sorted: #size descending
]

{ #category : #printing }
DMPackageViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'

	
]

{ #category : #accessing }
DMPackageViewModel >> size [
	^ size
]

{ #category : #accessing }
DMPackageViewModel >> suffixViewModels [
	^ suffixViewModels
]

{ #category : #accessing }
DMPackageViewModel >> suffixViewModels: collectionOfConceptViewModels [
	suffixViewModels := collectionOfConceptViewModels.
	size := (collectionOfConceptViewModels flatCollect: #classViewModels) size
]
