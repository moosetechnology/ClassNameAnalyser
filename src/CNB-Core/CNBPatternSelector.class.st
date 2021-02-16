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
CNBPatternSelector >> selectHomogeneous [
	| homogeneousModels models |
	models := cnb viewModel packageViewModels flatCollect: #models.
	homogeneousModels := models select: [ :each | each isHomogeneous ].
	^homogeneousModels 
]
