Class {
	#name : #DMConceptViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'models'
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

{ #category : #testing }
DMConceptViewModel >> isConceptViewModel [
	^ true
]

{ #category : #accessing }
DMConceptViewModel >> label [
	^name
]

{ #category : #accessing }
DMConceptViewModel >> models [
	^ models 
]

{ #category : #accessing }
DMConceptViewModel >> root [
	^root
]

{ #category : #accessing }
DMConceptViewModel >> root: biggestHierarchy [
	root := biggestHierarchy
]

{ #category : #'as yet unclassified' }
DMConceptViewModel >> rootname [
	^ self rootClass name
]
