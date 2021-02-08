"
I hold the models of the ClassNames Blueprint visualization
"
Class {
	#name : #DMViewModel,
	#superclass : #DMConceptualModel,
	#instVars : [
		'packageViewModels',
		'border'
	],
	#category : #CNBModels
}

{ #category : #accessing }
DMViewModel >> border [
	^border color: Color black;yourself
]

{ #category : #accessing }
DMViewModel >> classViewModels [ 
	^ ((packageViewModels 
		flatCollect: 
			#suffixViewModels) flatCollect: 
				[ :each | each classViewModels ])
]

{ #category : #initialization }
DMViewModel >> initialize [
	super initialize.
	border := RSBorder new. 
]

{ #category : #accessing }
DMViewModel >> models [
	^packageViewModels 
]

{ #category : #'as yet unclassified' }
DMViewModel >> modelsOrderedAscending [
	^packageViewModels sorted: #size ascending
]

{ #category : #'as yet unclassified' }
DMViewModel >> modelsOrderedDescending [
	^ packageViewModels sorted: #size descending
]

{ #category : #accessing }
DMViewModel >> packageViewModels [
	^ packageViewModels 
]

{ #category : #accessing }
DMViewModel >> packageViewModels: collectionOfPackageViewModels [
 
	packageViewModels := collectionOfPackageViewModels 
]
