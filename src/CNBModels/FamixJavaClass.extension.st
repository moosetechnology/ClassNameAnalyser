Extension { #name : #FamixJavaClass }

{ #category : #'*CNBModels' }
FamixJavaClass >> classDepthAccordingTo: aRoot [

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
FamixJavaClass >> classModelAccordingTo: setting [

	^ CNBClassModel of: self accordingTo: setting

]

{ #category : #'*CNBModels' }
FamixJavaClass >> isMono [ 

	^ self superclass = Object 
]

{ #category : #'*CNBModels' }
FamixJavaClass >> rootAccordingTo: aRootClass [

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
