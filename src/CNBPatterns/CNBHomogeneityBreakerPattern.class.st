"
Pattern: Homogeneity-Breaker;
	do not confuse me with the intruder anti-pattern.
	The same tokens I hold can be found elsewhere in other packages, 
	therefore I may mark common words in the project
"
Class {
	#name : #CNBHomogeneityBreakerPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'tokenSize',
		'occurrences'
	],
	#category : #CNBPatterns
}

{ #category : #validation }
CNBHomogeneityBreakerPattern class >> check: aTokenModel [
	^ self new
		check: aTokenModel
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> belongers [ 
	^ 50
]

{ #category : #validation }
CNBHomogeneityBreakerPattern >> check: aTokenModel [
	
	| belongersThreshold |
	aTokenModel outsiders ifEmpty: [ ^ false ].
	(aTokenModel size < self tokenSize) ifTrue: [ ^ false ].
	(aTokenModel innerRoots 
		anySatisfy: [ :each | each isMonoClass or: [ each isTrait ] ])  ifTrue: [ ^ false ].
	
	(aTokenModel belongers isNotEmpty and: [ 
		aTokenModel belongers allSatisfy: [ :each | each root isMonoClass or: [ each root isTrait ] ]])
	ifTrue: [ ^ false ].
	
	belongersThreshold := ((aTokenModel belongers size * 100 )/ aTokenModel outsiders size) > self belongers.
	
	belongersThreshold ifTrue: [ ^ false ].

	^ ((self checkMonoToken: aTokenModel) 
		or: [ self checkMultiToken: aTokenModel ]).
		
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkMainToken: aTokenModel [
	| belongersThreshold |
		belongersThreshold := ((aTokenModel belongers size * 100 )/ aTokenModel outsiders size) > self belongers.
	
	belongersThreshold ifTrue: [ ^ false ].
]

{ #category : #checking }
CNBHomogeneityBreakerPattern >> checkMonoToken: aTokenModel [
	

	^ ((aTokenModel 
				root isMonoToken) and: [ (aTokenModel outsidersRoots allSatisfy: [ :each | each isMultiToken ])
				and: [ aTokenModel outsidersRoots asSet hasOneElement "are not monoclasses"  ] ]).
]

{ #category : #checking }
CNBHomogeneityBreakerPattern >> checkMultiToken: aTokenModel [
	
	| mono |
	mono := aTokenModel outsidersRoots select: [ :each | each isMonoToken ].
	
	((aTokenModel outsiders collect: #root) size < 2) ifTrue: [ ^ false ].

	^ (aTokenModel 
			root isMultiToken) and: [ 
				(mono size / aTokenModel size) * 100 > 60
			 ]
			
]

{ #category : #checking }
CNBHomogeneityBreakerPattern >> checkSizeCondition: aTokenModel [

	^ (aTokenModel 
		size
		 	between: self minMonoTokenSize
		 	and: self maxMonoTokenSize).
]

{ #category : #checking }
CNBHomogeneityBreakerPattern >> checkTokenOutsiders: aTokenModel [

	^ ((aTokenModel outsiders collect: #root) asSet hasOneElement or: [ 
		 aTokenModel outsiders allSatisfy: [ :each | 
			 each root isHomogeneous ] ])
]

{ #category : #checking }
CNBHomogeneityBreakerPattern >> checkTokenType: aTokenModel [

	^ (aTokenModel root 
							isMonoToken or: [ aTokenModel root 
							isMultiToken ])
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> description [

	^ description
]

{ #category : #initialization }
CNBHomogeneityBreakerPattern >> initialize [
	super initialize.
	
	description := 
	'Pattern: Homogeneity-Breaker;
	do not confuse me with the intruder anti-pattern.
	The same tokens I hold can be found elsewhere in other packages, 
	therefore I may mark common words in the project
	 '.
	name := #'Homogeneity Breaker'.
	tokenSize := 3. 
	occurrences := 2.
 
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> name [

	^ name
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> occurrences [
	^ occurrences
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> tokenSize [
	^ tokenSize
]
