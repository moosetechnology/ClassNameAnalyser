Extension { #name : #Class }

{ #category : #'*CNBModels' }
Class >> classModelAccordingTo: setting [

	^ CNBClassModel of: self accordingTo: setting
	
]

{ #category : #'*CNBModels' }
Class >> rootAccordingTo: aRootClass [

	(self isTrait or: [ aRootClass = self ])
		ifTrue: [ ^ self ].
		
	self superclass isNotNil
		ifFalse: [ ^ self ].
		
	self superclass = aRootClass
		ifTrue: [ ^ self ].

	^ self superclass rootAccordingTo: aRootClass
	
]
