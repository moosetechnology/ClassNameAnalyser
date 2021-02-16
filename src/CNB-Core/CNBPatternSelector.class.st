Class {
	#name : #CNBPatternSelector,
	#superclass : #Object,
	#instVars : [
		'cnb',
		'intrudersPercentage',
		'fatBlobSize',
		'snowFlakesSize'
	],
	#category : #'CNB-Core'
}

{ #category : #'as yet unclassified' }
CNBPatternSelector class >> fatBlobSize [
	^self new
		fatBlobSize 
]

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
CNBPatternSelector class >> snowFlakesSize [
	^self new
		snowFlakesSize
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
	intrudersPercentage := 50.
	fatBlobSize := 7.
	snowFlakesSize := 3 
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
