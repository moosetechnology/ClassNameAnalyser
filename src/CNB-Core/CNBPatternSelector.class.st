Class {
	#name : #CNBPatternSelector,
	#superclass : #Object,
	#instVars : [
		'cnb',
		'intrudersPercentage',
		'fatBlobSize',
		'snowFlakesSize',
		'confettiSize'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
CNBPatternSelector class >> confettiSize [ 
	^self new
		confettiSize 
]

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

{ #category : #accessing }
CNBPatternSelector >> confettiSize [ 
	^ confettiSize 
]

{ #category : #accessing }
CNBPatternSelector >> fatBlobSize [ 
	^ fatBlobSize 
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
	snowFlakesSize := 3.
	confettiSize := 3
]

{ #category : #accessing }
CNBPatternSelector >> intrudersPercentage [
	^ intrudersPercentage 
]

{ #category : #accessing }
CNBPatternSelector >> models [
	^ cnb viewModel packageViewModels flatCollect: #models.
]

{ #category : #'instance creation' }
CNBPatternSelector >> of: aCNB [
	cnb := aCNB
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectConfetti [
	
	^ self models select: [ :each | each isConfetti ]

	
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectFatBlob [

	^ self models select: [ :each | each isFatBlob ].
	
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectHomogeneous [
	
	^ self models select: [ :each | each isHomogeneous ]
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectIntruders [
	
	^ self models select: [ :each | each hasIntruders ]
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectSnowFlakes [
	
	^ self models select: [ :each | each isSnowFlakes ]
]

{ #category : #accessing }
CNBPatternSelector >> snowFlakesSize [ 
	^ snowFlakesSize 
]
