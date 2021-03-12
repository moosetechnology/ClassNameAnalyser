Class {
	#name : #CNBPackageViewModelOragnizer,
	#superclass : #Object,
	#instVars : [
		'package'
	],
	#category : #CNBModels
}

{ #category : #'instance creation' }
CNBPackageViewModelOragnizer class >> of: aPackageModel [
	^ self new
		package: aPackageModel 
]

{ #category : #'as yet unclassified' }
CNBPackageViewModelOragnizer >> organize: aPackage accordingTo: anOtherPackage [ 

	| scatteredRoots |
	scatteredRoots := aPackage scatteredRoots.
	
	scatteredRoots do: [ :each | | otherPAckageTokens |
		otherPAckageTokens := (anOtherPackage tokensOf: each name).
		(((aPackage tokensOf: each name) size > otherPAckageTokens size)
			and: [ (otherPAckageTokens anySatisfy: [ :aToken | aToken hasNoOutsiders ])
				  
				and: [  each dominantTokens keys
							includes: (otherPAckageTokens detectMax: [ :any | any hasNoOutsiders ]) name].
						 ]) ifFalse: [ 
				
				aPackage replaceTokensOf: each with: otherPAckageTokens. 				
				
				 ] 
		
		 ].
	
]
