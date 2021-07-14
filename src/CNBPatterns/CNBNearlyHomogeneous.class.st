"
Pattern: Homogeneity-Breaker;
	do not confuse me with the intruder anti-pattern.
	The same tokens I hold can be found elsewhere in other packages, 
	therefore I may mark common words in the project
"
Class {
	#name : #CNBNearlyHomogeneous,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'tokenSize',
		'occurrences'
	],
	#category : #CNBPatterns
}

{ #category : #validation }
CNBNearlyHomogeneous class >> check: aTokenModel [
	^ self new
		check: aTokenModel
]

{ #category : #accessing }
CNBNearlyHomogeneous >> belongers [ 
	^ 50
]

{ #category : #validation }
CNBNearlyHomogeneous >> check: aRootModel [
	
	| nearlyHomogeneous tokens |
	tokens := aRootModel tokensDictionary keys.
	
	nearlyHomogeneous 
		:= (tokens asOrderedCollection 
				add: aRootModel token;
				yourself) asSet size = occurrences.
				
	(nearlyHomogeneous and: [ aRootModel isMultiToken ]) 
		ifTrue: [ aRootModel isNearlyHomogeneous ].
]

{ #category : #accessing }
CNBNearlyHomogeneous >> description [

	^ description
]

{ #category : #initialization }
CNBNearlyHomogeneous >> initialize [
	super initialize.
	
	description := 
	'Pattern: Homogeneity-Breaker;
	do not confuse me with the intruder anti-pattern.
	The same tokens I hold can be found elsewhere in other packages, 
	therefore I may mark common words in the project
	 '.
	name := #'Nearly Homogeneous'.
	tokenSize := 4. 
	occurrences := 2.
 
]

{ #category : #accessing }
CNBNearlyHomogeneous >> name [

	^ name
]
