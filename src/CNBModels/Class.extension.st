Extension { #name : #Class }

{ #category : #'*CNBModels' }
Class >> classDepthAccordingTo: aRootName [

	" we use the name since the provided root from the tool is a text"
	
	"Stops if Object is the superclass"	
	"if trait of is the root itself "
	(self isTrait or: [ self name = aRootName or: self superclass = Object ])
		ifTrue: [ ^ 1 ].
		
	"Stops if the superclass is the root class"
	self superclass name = aRootName
		ifTrue: [ ^ 1 ].
		
	^ (self superclass classDepthAccordingTo: aRootName) + 1
	
]

{ #category : #'*CNBModels' }
Class >> classModelAccordingTo: setting [

	^ CNBClassModel of: self accordingTo: setting
	
]

{ #category : #'*CNBModels' }
Class >> exists [ 
	^ true
]

{ #category : #'*CNBModels' }
Class >> isMono [ 
	^ superclass = Object and: [ self subclasses isEmpty ]
]

{ #category : #'*CNBModels' }
Class >> rootAccordingTo: aRootClassName [

	" we use the name since the provided root from the tool is a text"
	
	"Stops if Object is the superclass"	
	"if trait of is the root itself "
	( self isTrait or: [ self name = aRootClassName or: self superclass = Object ])
		ifTrue: [ ^ self ].
		
	"Stops if the superclass is the root class"
	self superclass name = aRootClassName
		ifTrue: [ ^ self ].
		
	^ self superclass rootAccordingTo: aRootClassName
	
]
