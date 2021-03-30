Extension { #name : #FAMIXType }

{ #category : #'*CNBModels' }
FAMIXType >> classDepthAccordingTo: aRoot [

	(self isMono or: [ self = aRoot ])
		ifTrue: [ ^ 1 ].
		
	self superclass ifNil: [ ^ 1 ].
		
	self superclass = aRoot
		ifTrue: [ ^ 1 ].
		
	self superclass = Object 
		ifTrue: [ ^ 1 ].

	^ (self superclass classDepthAccordingTo: aRoot) + 1
	
]

{ #category : #'*CNBModels' }
FAMIXType >> isMono [ 

	^ self superclass = Object 
]

{ #category : #'*CNBModels' }
FAMIXType >> rootAccordingTo: aRootClass [

	(self isTrait or: [ self name = aRootClass name  ])
		ifTrue: [ ^ self ].
		
	self superclass isNotNil
		ifFalse: [ ^ self ].
		
	self superclass name = aRootClass name
		ifTrue: [ ^ self ].
		
	(self superclass isInterface)
		ifTrue: [ ^ self ].
		
	self superclass = Object 
		ifTrue: [ ^ self ].
		
	^ self superclass rootAccordingTo: aRootClass
	
]
