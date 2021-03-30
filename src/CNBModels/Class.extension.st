Extension { #name : #Class }

{ #category : #'*CNBModels' }
Class >> classDepthAccordingTo: aRoot [

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
Class >> classModelAccordingTo: setting [

	^ CNBClassModel of: self accordingTo: setting
	
]

{ #category : #'*CNBModels' }
Class >> isMono [ 
	^ superclass = Object and: [ self subclasses isEmpty ]
]

{ #category : #'*CNBModels' }
Class >> rootAccordingTo: aRootClass [

	(self isTrait or: [ self isMono ])
		ifTrue: [ ^ self ].
		
	self superclass isNotNil
		ifFalse: [ ^ self ].
		
	self superclass = aRootClass
		ifTrue: [ ^ self ].
		
	self superclass = Object 
		ifTrue: [ ^ self ].

	^ self superclass rootAccordingTo: aRootClass
	
]
