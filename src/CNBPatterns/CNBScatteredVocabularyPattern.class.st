Class {
	#name : #CNBScatteredVocabularyPattern,
	#superclass : #CNBAbstractPattern,
	#category : #CNBPatterns
}

{ #category : #validation }
CNBScatteredVocabularyPattern >> check: aSuffixModel [

	^ aSuffixModel root hasScatteredVocabularyInside: aSuffixModel package 
	

]

{ #category : #accessing }
CNBScatteredVocabularyPattern >> description [
	^ description
]

{ #category : #initialization }
CNBScatteredVocabularyPattern >> initialize [
	super initialize.
	description := 'I am a Scattered Vocabulary'.
	name := #'Scattered Vocabulary'
]

{ #category : #accessing }
CNBScatteredVocabularyPattern >> name [
	^ name
]
