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
	
	scatteredRoots do: [ :each | | otherPAckageTokens commonToken |
		otherPAckageTokens := (anOtherPackage tokensOf: each name).
		(((aPackage tokensOf: each name) size > otherPAckageTokens size)
			and: [ (otherPAckageTokens anySatisfy: [ :aToken | aToken hasNoOutsiders ])
				  
				and: [ 
						commonToken := otherPAckageTokens detectMax: [ :aToken | aToken size ].
						(each dominantTokens keys
							includes: commonToken name )
								and: [	 commonToken hasNoOutsiders ]
							].
						 ]) ifTrue: [ 
				
				aPackage replaceTokensOf: each with: otherPAckageTokens. 				
				
				 ] 
		
		 ].
	
]
