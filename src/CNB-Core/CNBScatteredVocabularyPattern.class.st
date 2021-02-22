Class {
	#name : #CNBScatteredVocabularyPattern,
	#superclass : #CNBAbstractPattern,
	#category : #'CNB-Core'
}

{ #category : #validation }
CNBScatteredVocabularyPattern >> check: aRoot [
	^ aRoot hasScatteredVocabulary 
	

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
