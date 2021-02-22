Class {
	#name : #CNBFatBlobPattern,
	#superclass : #CNBAbstractPattern,
	#category : #'CNB-Core'
}

{ #category : #validation }
CNBFatBlobPattern >> check: aSuffixModel [
	(aSuffixModel classViewModels size >= CNBPatternSelector fatBlobSize
		and: [ 
	aSuffixModel innerRoots asSet size = 1		 			
	])
		ifFalse: [ ^false ]
		ifTrue: [ 
			^ (aSuffixModel innerRoots atRandom 
					isMonoSuffix not 
						and: [ 
						aSuffixModel innerRoots atRandom 
							isMonoClass not 
				])
			 ]. 
]

{ #category : #accessing }
CNBFatBlobPattern >> description [ 
	^ 'I am  FAT BLOB'
]

{ #category : #initialization }
CNBFatBlobPattern >> initialize [
	super initialize.
]
