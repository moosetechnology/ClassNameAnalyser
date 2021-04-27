"
Pattern: Fat Blob; usually I am the only one of my kind per package. 
	I hold several classes of my hierarchy which use the same token. 
	Thus, my hierarchy follows a naming pattern
"
Class {
	#name : #CNBFatBlobPattern,
	#superclass : #CNBAbstractPattern,
	#instVars : [
		'fatBlobSize',
		'maxOutsiders'
	],
	#category : #CNBPatterns
}

{ #category : #accessing }
CNBFatBlobPattern class >> fatBlobSize [ 
	^ self new 
		fatBlobSize 
]

{ #category : #accessing }
CNBFatBlobPattern class >> maxOutsiders [ 
	^ self new
		maxOutsiders 
]

{ #category : #validation }
CNBFatBlobPattern >> check: aTokenModel [

	aTokenModel belongers size >= self fatBlobSize 
		ifFalse: [ ^ false ]
	
		ifTrue: [ 
			^ (aTokenModel root isMonoToken not and: [ 
				aTokenModel root isMonoClass not and: [ 
				aTokenModel root isTrait not and: [  
					aTokenModel outsiders size <= maxOutsiders ]
				]
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
	fatBlobSize := 7.
	description := 
	'Pattern: Fat Blob; usually I am the only one of my kind per package. 
	I hold several classes of my hierarchy which use the same token. 
	Thus, my hierarchy follows a naming pattern'.
	name := #'Fat Blob'.
	maxOutsiders := 1
	 
]

{ #category : #accessing }
CNBFatBlobPattern >> maxOutsiders [ 
	^ maxOutsiders 
]

{ #category : #accessing }
CNBFatBlobPattern >> name [

	^ name
]
