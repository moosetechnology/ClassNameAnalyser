Class {
	#name : #CNBPatternSelector,
	#superclass : #Object,
	#instVars : [
		'cnb'
	],
	#category : #'CNB-Core'
}

{ #category : #'instance creation' }
CNBPatternSelector class >> of: aCNB [
	^ self new
		of: aCNB
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
	intrudersModels := models select: [ :each | each hasIntruder ].
	^intrudersModels 
]

{ #category : #'as yet unclassified' }
CNBPatternSelector >> selectSnowFlakes [
	| snowFlakesModels models |
	models := cnb viewModel packageViewModels flatCollect: #models.
	snowFlakesModels := models select: [ :each | each isSnowFlakes ].
	^snowFlakesModels 
]
