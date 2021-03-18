Extension { #name : #FAMIXType }

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
		
	^ self superclass rootAccordingTo: aRootClass
	
]
