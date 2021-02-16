"
I hold the models of the ClassNames Blueprint visualization
"
Class {
	#name : #CNBViewModel,
	#superclass : #CNBConceptualModel,
	#instVars : [
		'packageViewModels',
		'border',
		'defaultColor',
		'settings'
	],
	#category : #CNBModels
}

{ #category : #'accessing - attributes' }
CNBViewModel >> attributeSuffixModelsToRoots [
	| suffixModels |
	suffixModels := packageViewModels flatCollect: #suffixViewModels.
	
	rootModels 
		do: [ :aRoot | 
			aRoot resetConcepts.
			aRoot concepts addAll: (suffixModels select: [ :each | each root == aRoot ]) ]
]

{ #category : #accessing }
CNBViewModel >> border [
	^border color: Color black;yourself
]

{ #category : #'building actions' }
CNBViewModel >> buildRoassal3View [ 
	^CNBRoassal3Builder build: self 
]

{ #category : #accessing }
CNBViewModel >> classViewModels [ 
	^ ((packageViewModels 
		flatCollect: 
			#suffixViewModels) flatCollect: 
				[ :each | each classViewModels ])
]

{ #category : #accessing }
CNBViewModel >> color [
	^defaultColor
]

{ #category : #accessing }
CNBViewModel >> defaultColor [ 
	^Color white darker
]

{ #category : #initialization }
CNBViewModel >> initialize [
	super initialize.
	border := RSBorder new.
	settings := CNBSettings new
]

{ #category : #accessing }
CNBViewModel >> models [
	^packageViewModels 
]

{ #category : #accessing }
CNBViewModel >> modelsOrderedAscending [
	^packageViewModels sorted: #size ascending
]

{ #category : #accessing }
CNBViewModel >> modelsOrderedDescending [
	^ packageViewModels sorted: #size descending
]

{ #category : #accessing }
CNBViewModel >> packageViewModels [
	^ packageViewModels 
]

{ #category : #accessing }
CNBViewModel >> packageViewModels: collectionOfPackageViewModels [
 
	packageViewModels := collectionOfPackageViewModels 
]

{ #category : #accessing }
CNBViewModel >> settings [
	^settings
]
