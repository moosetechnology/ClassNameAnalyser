Class {
	#name : #CNBFatBlobPattern,
	#superclass : #CNBAbstractPattern,
	#category : #CNBPatterns
}

{ #category : #validation }
CNBFatBlobPattern >> check: aSuffixModel [

	(aSuffixModel classViewModels size >= CNBPatternSelector fatBlobSize and: [ 
		aSuffixModel outsiders isEmpty	])
		ifFalse: [ ^ false ]
		
		ifTrue: [ 
			^ (aSuffixModel root isMonoSuffix not and: [ aSuffixModel root isMonoClass not 
				]) ]. 
]

{ #category : #accessing }
CNBFatBlobPattern >> description [ 
	^ description
]

{ #category : #initialization }
CNBFatBlobPattern >> initialize [
	super initialize.
	description := 'I am  FAT BLOB'.
	name := #'Fat Blob'
]

{ #category : #accessing }
CNBFatBlobPattern >> name [
	^ name
]
