Class {
	#name : #CNBScatteredVocabularyPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'minClassSize',
		'minTokenSize',
		'threshold'
	],
	#category : #CNBPatterns
}

{ #category : #validation }
CNBScatteredVocabularyPattern >> check: aTokenModel [

	^ aTokenModel 
			root hasScatteredVocabularyInside: aTokenModel package 
	

]

{ #category : #accessing }
CNBScatteredVocabularyPattern >> description [

	^ description
]

{ #category : #initialization }
CNBScatteredVocabularyPattern >> initialize [
	super initialize.
	
	description := 
	'Anti-Pattern: Scattered Vocabulary, my hierarchy uses and dominates several tokens, 
	it is not consistently named/does not follow a particular naming pattern.'.
	name := #'Scattered Vocabulary'.
	minClassSize := 1.
	minTokenSize := 3.
	threshold := 10
]

{ #category : #accessing }
CNBScatteredVocabularyPattern >> minClassSize [

	^ minClassSize
]

{ #category : #accessing }
CNBScatteredVocabularyPattern >> minTokenSize [

	^ minTokenSize
]

{ #category : #accessing }
CNBScatteredVocabularyPattern >> name [

	^ name
]

{ #category : #accessing }
CNBScatteredVocabularyPattern >> threshold [
	^ threshold
]
