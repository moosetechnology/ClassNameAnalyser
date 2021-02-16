Class {
	#name : #CNBPatternSelector,
	#superclass : #Object,
	#instVars : [
		'cnb',
		'intrudersPercentage'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
CNBPatternSelector class >> intrudersPercentage [ 
	^self new
		intrudersPercentage 
]

{ #category : #'instance creation' }
CNBPatternSelector class >> of: aCNB [
	^ self new
		of: aCNB
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> hasIntrudersPercentageOf: aPercentage [
	| intrudersModels models |
	models := cnb viewModel packageViewModels flatCollect: #models.
	intrudersModels := models select: [ :each | each hasIntruder ].
	^intrudersModels 
]

{ #category : #initialization }
CNBPatternSelector >> initialize [ 
	super initialize.
	intrudersPercentage := 50
]

{ #category : #accessing }
CNBPatternSelector >> intrudersPercentage [
	^intrudersPercentage 
]

{ #category : #'instance creation' }
CNBPatternSelector >> of: aCNB [
	cnb := aCNB
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectFatBlob [
	| fatBlobModels models |
	models := cnb viewModel packageViewModels flatCollect: #models.
	fatBlobModels := models select: [ :each | each isFatBlob ].
	^fatBlobModels 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectHomogeneous [
	| homogeneousModels models |
	models := cnb viewModel packageViewModels flatCollect: #models.
	homogeneousModels := models select: [ :each | each isHomogeneous ].
	^homogeneousModels 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectIntruders [
	| intrudersModels models |
	models := cnb viewModel packageViewModels flatCollect: #models.
	intrudersModels := models select: [ :each | each hasIntruders ].
	^intrudersModels 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectSnowFlakes [
	| snowFlakesModels models |
	models := cnb viewModel packageViewModels flatCollect: #models.
	snowFlakesModels := models select: [ :each | each isSnowFlakes ].
	^snowFlakesModels 
]
