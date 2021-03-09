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

{ #category : #attribution }
CNBViewModel >> attributePatterns [
	self tokenModels do: [ :each | each attributePattern ]
]

{ #category : #'accessing - attributes' }
CNBViewModel >> attributeTokenModelsToRoots [
	
	rootModels 
		do: [ :aRoot | 
			aRoot tokenModels: (self tokenModels select: [ :each | each root == aRoot ]) ]
]

{ #category : #accessing }
CNBViewModel >> border [
	^ border color: Color black;yourself
]

{ #category : #'building actions' }
CNBViewModel >> buildRoassal3View [ 
	^ CNBRoassal3Builder build: self 
]

{ #category : #accessing }
CNBViewModel >> classViewModels [ 
	^ ((packageViewModels 
		flatCollect: 
			#tokenViewModels) flatCollect: 
				[ :each | each classViewModels ])
]

{ #category : #accessing }
CNBViewModel >> color [
	^ defaultColor
]

{ #category : #accessing }
CNBViewModel >> defaultColor [ 
	^ Color white darker
]

{ #category : #initialization }
CNBViewModel >> initialize [
	super initialize.
	border := RSBorder new.
	settings := CNBSettings new
]

{ #category : #accessing }
CNBViewModel >> modelsOrderedAscending [
	^ packageViewModels sorted: #size ascending
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
	^ settings
]

{ #category : #operations }
CNBViewModel >> startBuilding [ 

	| thePackageModels |
	thePackageModels := CNBBuilder doPackageModelsOf: self.
	
	self 
		name: model name;
		packageModels: thePackageModels.
		self
		rootModels: (CNBBuilder
				 doRootsOf: (thePackageModels flatCollect: #classModels)
				 Accordingto: settings).

		self packageViewModels: (CNBBuilder doPackageViewModelsOf: self).
		self attributeTokenModelsToRoots.
		self attributePatterns.
]

{ #category : #'accessing - attributes' }
CNBViewModel >> tokenModels [	

	^ packageViewModels flatCollect: #tokenViewModels.
]
