Class {
	#name : #CNBAbstractPattern,
	#superclass : #Object,
	#instVars : [
		'description',
		'condition',
		'elements',
		'name'
	],
	#category : #CNBPatterns
}

{ #category : #accessing }
CNBAbstractPattern >> condition [
	self subclassResponsibility 
]

{ #category : #accessing }
CNBAbstractPattern >> description [
	^ description 
]

{ #category : #accessing }
CNBAbstractPattern >> elements [
	^ elements
]

{ #category : #testing }
CNBAbstractPattern >> isConfetti [

	^ self name = #'Confetti'
]

{ #category : #testing }
CNBAbstractPattern >> isFatBlob [

	^ self name = #'Fat Blob'
]

{ #category : #testing }
CNBAbstractPattern >> isHomogeneityBreaker [

	^ self name = #'Homogeneity Breaker'
]

{ #category : #testing }
CNBAbstractPattern >> isHomogeneous [ 

	^ self name = #'Homogeneous'
]

{ #category : #testing }
CNBAbstractPattern >> isIntruder [ 

	^ self name = #'Intruder'
]

{ #category : #testing }
CNBAbstractPattern >> isScatteredVocabulary [

	^ self name = #'Scattered Vocabulary'
]

{ #category : #testing }
CNBAbstractPattern >> isSnowFlakes [ 
	^ self name = #'Snow Flakes'
]

{ #category : #accessing }
CNBAbstractPattern >> name [
	self subclassResponsibility 
]
