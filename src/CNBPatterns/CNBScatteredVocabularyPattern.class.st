"
Anti-Pattern: Scattered Vocabulary, my hierarchy uses and dominates several tokens, 
	it is not consistently named/does not follow a particular naming pattern.
"
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

{ #category : #'instance creation' }
CNBScatteredVocabularyPattern class >> newInstance [ 
	^ self new
]

{ #category : #validation }
CNBScatteredVocabularyPattern >> check: aRootModel [

	| isScattered tokens |
	tokens := aRootModel tokensDictionary keys.

	isScattered := (tokens asOrderedCollection
		                add: aRootModel token;
		                yourself) asSet size >= minTokenSize.

	(isScattered and: [ aRootModel isMultiToken ]) ifTrue: [
		aRootModel hasScatteredVocabulary ]
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
	minClassSize := 2.
	minTokenSize := 3.
	threshold := 20
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

{ #category : #accessing }
CNBScatteredVocabularyPattern >> threshold: blongersSize [
	^ ((threshold * blongersSize)/100) asFloat
]
