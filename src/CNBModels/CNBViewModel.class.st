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
		'setting'
	],
	#category : #CNBModels
}

{ #category : #attribution }
CNBViewModel >> attributePatterns [

	self tokenModels do: [ :each | each attributePattern ].
	self rootModels do: [ :each | each attributePatterns ]
]

{ #category : #'accessing - attributes' }
CNBViewModel >> attributeTokenModelsToRoots [

	rootModels 
		do: [ :aRoot | 
			aRoot tokenModels: (self tokenModels select: [ :each | each root == aRoot ]) ].
			
]

{ #category : #accessing }
CNBViewModel >> border [

	^ border 
		color: Color black;
		yourself
]

{ #category : #'building actions' }
CNBViewModel >> buildRoassal3View [ 

	^ CNBRoassal3Builder build: self 
]

{ #category : #accessing }
CNBViewModel >> classViewModels [ 

	| classes |
	classes := (
			(packageViewModels 
				flatCollect: #tokenViewModels) 
					flatCollect: [ :each | each classViewModels ]
		).
	
	^ classes
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
	setting := CNBSettings new.

]

{ #category : #accessing }
CNBViewModel >> modelsOrderedAscending [

	^ (packageViewModels sorted: #name ascending) sorted: #size ascending
]

{ #category : #accessing }
CNBViewModel >> modelsOrderedDescending [

	self packageViewModels: ((packageViewModels sorted: #name ascending) sorted: #size descending)
]

{ #category : #accessing }
CNBViewModel >> packageViewModels [

	^ packageViewModels 
]

{ #category : #accessing }
CNBViewModel >> packageViewModels: collection [
 
	packageViewModels := collection 
]

{ #category : #'as yet unclassified' }
CNBViewModel >> scatteredPackages [ 

	| scattered |
	scattered := packageViewModels select: [ :each | each hasScatteredVocabularyInside ].
	
	^ scattered
]

{ #category : #accessing }
CNBViewModel >> setting [

	^ setting
]

{ #category : #accessing }
CNBViewModel >> setting: aSetting [

	setting := aSetting 
]

{ #category : #'accessing - attributes' }
CNBViewModel >> tokenModels [	

	^ self tokenViewModels 
]

{ #category : #accessing }
CNBViewModel >> tokenViewModels [ 
	
	^ packageViewModels flatCollect: [ :each | each tokenViewModels ]
]

{ #category : #'as yet unclassified' }
CNBViewModel >> withPrefix [

	setting token: #prefix
]

{ #category : #'as yet unclassified' }
CNBViewModel >> withSuffix [

	setting token: #suffix
]
