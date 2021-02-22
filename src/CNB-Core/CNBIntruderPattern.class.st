Class {
	#name : #CNBIntruderPattern,
	#superclass : #CNBAbstractPattern,
	#category : #'CNB-Core'
}

{ #category : #validation }
CNBIntruderPattern >> check: aSuffixModel [

	| potentialIntrudersPercentage  potentialIntruders |
	(aSuffixModel classViewModels 
		size >= 
			CNBPatternSelector nbrIntrudersNeighbors) 
				ifFalse: [ ^ false ].
				
	potentialIntruders := (aSuffixModel innerRoots select: [ :each | each ~= aSuffixModel root ]).
	
	potentialIntrudersPercentage := ((potentialIntruders size * 100) / aSuffixModel size) asFloat.
	
	(potentialIntruders 
		anySatisfy: [ :each | each isMonoClass ])
		ifTrue: [ ^false ] 
		ifFalse: [  
	 			^((potentialIntruders asSet size = 1) 
				and: 
			[ potentialIntrudersPercentage <= CNBPatternSelector intrudersPercentage ]) ]
	
	
]
