Class {
	#name : #CNBHomogeneityBreakerPattern,
	#superclass : #CNBAbstractPattern,
	#category : #CNBPatterns
}

{ #category : #validation }
CNBHomogeneityBreakerPattern class >> check: aSuffixModel [
	^ self new
		check: aSuffixModel
]

{ #category : #validation }
CNBHomogeneityBreakerPattern >> check: aSuffixModel [

	^ ((self checkMonoSuffix: aSuffixModel) or: [ self checkMultiSuffix: aSuffixModel ]).
		
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkMonoSuffix: aSuffixModel [
	
	^ ((aSuffixModel root isMonoSuffix) 
			and: [ (aSuffixModel outsiders collect: #root) asSet size = 1 
				and: [ aSuffixModel outsiders size
					between: CNBPatternSelector hbMonoMinSuffixSize 
					and: CNBPatternSelector hbMaxSuffixSize ] ]).
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkMultiSuffix: aSuffixModel [

	^ (aSuffixModel root isMultiSuffix)
		and: [ ((aSuffixModel outsiders collect: #root) allSatisfy: [ :each | each isMonoSuffix ])
			and: [ aSuffixModel outsiders size 
				between:  CNBPatternSelector hbMultiMinSuffixSize
				and: CNBPatternSelector hbMonoMaxSuffixSize ] ].
		"hbMultiPourcentage * aSuffixModel outsiders size) percent "
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkSizeCondition: aSuffixModel [

	^ (aSuffixModel size
		 between: CNBPatternSelector hbMonoMinSuffixSize
		 and: CNBPatternSelector hbMonoMaxSuffixSize).
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkSuffixOutsiders: aSuffixModel [

	^ ((aSuffixModel outsiders collect: #root) asSet size = 1 or: [ 
		 aSuffixModel outsiders allSatisfy: [ :each | 
			 each root isHomogeneous ] ])
]

{ #category : #'as yet unclassified' }
CNBHomogeneityBreakerPattern >> checkSuffixType: aSuffixModel [

	^ (aSuffixModel root isMonoSuffix or: [ 
		 aSuffixModel root isMultiSuffix ])
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
