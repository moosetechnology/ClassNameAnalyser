Class {
	#name : #DMConceptViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'models',
		'size'
	],
	#category : #DMModels
}

{ #category : #'brick-properties' }
DMConceptViewModel >> borderColor [ 
	^ Color black
]

{ #category : #accessing }
DMConceptViewModel >> classViewModels: aCollectionOfClassViewModels [
	models := aCollectionOfClassViewModels 
]

{ #category : #accessing }
DMConceptViewModel >> color [ 
	^ color
]

{ #category : #accessing }
DMConceptViewModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMConceptViewModel >> label [
	^name
]

{ #category : #accessing }
DMConceptViewModel >> packageModels [
	^ models 
]

{ #category : #printing }
DMConceptViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: self root name.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMConceptViewModel >> root [
	^root
]

{ #category : #accessing }
DMConceptViewModel >> root: biggestHierarchy [
	root := biggestHierarchy
]

{ #category : #accessing }
DMConceptViewModel >> size [ 
	^models size
]
