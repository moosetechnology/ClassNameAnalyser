Class {
	#name : #CNBHomogeneityBreakerPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'maxMonoTokenSize',
		'minMultiTokenSize',
		'minMonoTokenSize',
		'occurrences'
	],
	#category : #CNBPatterns
}

{ #category : #validation }
CNBHomogeneityBreakerPattern class >> check: aTokenModel [
	^ self new
		check: aTokenModel
]

{ #category : #validation }
CNBHomogeneityBreakerPattern >> check: aTokenModel [
	
	((aTokenModel innerRoots 
		anySatisfy: [ :each | each isMonoClass ]) 
			or: [ aTokenModel root isMonoToken ]) ifTrue: [ ^ false ].
			
	^ ((self checkMonoToken: aTokenModel) 
		or: [ self checkMultiToken: aTokenModel ]).
		
]

{ #category : #checking }
CNBHomogeneityBreakerPattern >> checkMonoToken: aTokenModel [
	
	^ ((aTokenModel 
				root isMonoToken) and: [ aTokenModel 
				outsidersRoots asSet hasOneElement "are not monoclasses" and: [ aTokenModel 
				outsiders size
					between: self minMonoTokenSize 
					and: self maxMonoTokenSize ] ]).
]

{ #category : #checking }
CNBHomogeneityBreakerPattern >> checkMultiToken: aTokenModel [

	^ (aTokenModel 
			root isMultiToken) and: [ 
				(aTokenModel 
			outsiders collect: #color) asSet size 
			between: self minMonoTokenSize 
			and: self maxMonoTokenSize "and: [ aTokenModel 
			outsidersRoots asSet allSatisfy: [ :each | each isMonoToken ]
			 ]" ].
		"hbMultiPourcentage * aSuffixModel outsiders size) percent "
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
	'I am a Homogeneity-Breaker, 
	do not confuse me with the intruder anti-pattern.
	The same told I hold can be found elsewhere in other packages, 
	therefore I may mark common words in the project
	 '.
	name := #'Homogeneity Breaker'.
	minMonoTokenSize := 1. 
	maxMonoTokenSize := 6 .
	
	minMultiTokenSize := 2. 
	occurrences := 2. 
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> maxMonoTokenSize [

	^ maxMonoTokenSize
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> minMonoTokenSize [

	^ minMonoTokenSize
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> minMultiTokenSize [

	^ minMultiTokenSize
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> name [

	^ name
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> occurrences [ 
	^ occurrences
]
