Class {
	#name : #CNBFatBlobPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'fatBlobSize'
	],
	#category : #CNBPatterns
}

{ #category : #validation }
CNBFatBlobPattern >> check: aTokenModel [

	(aTokenModel classViewModels size >= self fatBlobSize and: [ 
		aTokenModel outsiders isEmpty	])
		ifFalse: [ ^ false ]
		
		ifTrue: [ 
			^ (aTokenModel root isMonoToken not and: [ aTokenModel root isMonoClass not 
				]) ]. 
]

{ #category : #accessing }
CNBFatBlobPattern >> description [ 

	^ description
]

{ #category : #accessing }
CNBFatBlobPattern >> fatBlobSize [ 

	^ fatBlobSize 
]

{ #category : #initialization }
CNBFatBlobPattern >> initialize [
	super initialize.
	
	description := 'I am  FAT BLOB'.
	name := #'Fat Blob'.
	fatBlobSize := 7. 
]

{ #category : #accessing }
CNBFatBlobPattern >> name [

	^ name
]
