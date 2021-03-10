Class {
	#name : #CNBHomogeneityBreakerPattern,
	#superclass : #CNBAbstractPattern,
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

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkMonoToken: aTokenModel [
	
	^ ((aTokenModel root isMonoToken) 
			and: [ (aTokenModel outsiders collect: #root) asSet size = 1 "are not monoclasses"
				and: [ aTokenModel outsiders size
					between: CNBPatternSelector hbMonoMinTokenSize 
					and: CNBPatternSelector hbMaxTokenSize ] ]).
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkMultiToken: aTokenModel [

	^ (aTokenModel root isMultiToken)
		and: [ ((aTokenModel outsiders collect: #root) allSatisfy: [ :each | each isMonoToken ])
			and: [ aTokenModel outsiders size 
				between:  CNBPatternSelector hbMultiMinTokenSize
				and: CNBPatternSelector hbMonoMaxTokenSize ] ].
		"hbMultiPourcentage * aSuffixModel outsiders size) percent "
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkSizeCondition: aTokenModel [

	^ (aTokenModel size
		 between: CNBPatternSelector hbMonoMinTokenSize
		 and: CNBPatternSelector hbMonoMaxTokenSize).
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkTokenOutsiders: aTokenModel [

	^ ((aTokenModel outsiders collect: #root) asSet size = 1 or: [ 
		 aTokenModel outsiders allSatisfy: [ :each | 
			 each root isHomogeneous ] ])
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkTokenType: aTokenModel [

	^ (aTokenModel root isMonoToken or: [ 
		 aTokenModel root isMultiToken ])
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> description [
	^ description
]

{ #category : #initialization }
CNBHomogeneityBreakerPattern >> initialize [
	super initialize.
	description := 'I am a Homogeneity-Breaker'.
	name := #'Homogeneity Breaker'
]

{ #category : #accessing }
CNBHomogeneityBreakerPattern >> name [
	^ name
]
