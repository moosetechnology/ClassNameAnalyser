Extension { #name : #FAMIXType }

{ #category : #'*CNBModels' }
FAMIXType >> rootAccordingTo: aRootClass [

	(self isTrait or: [ aRootClass = self ])
		ifTrue: [ ^ self ].
		
	self superclass isNotNil
		ifFalse: [ ^ self ].
		
	self superclass = aRootClass
		ifTrue: [ ^ self ].

	^ self superclass rootAccordingTo: aRootClass
	
]
