Extension { #name : #FamixStClass }

{ #category : #'*CNBModels' }
FamixStClass >> classDepthAccordingTo: aRootName [

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
FamixStClass >> classModelAccordingTo: setting [

	^ CNBClassModel of: self accordingTo: setting
	
]

{ #category : #'*CNBModels' }
FamixStClass >> exists [ 
	^ true
]

{ #category : #'*CNBModels' }
FamixStClass >> isMono [ 

	^ self superclass = Object and: [ self subInheritances isEmpty ]
]

{ #category : #'*CNBModels' }
FamixStClass >> isTrait [ 

	^ (Smalltalk image classNamed: self name) isTrait
]

{ #category : #'*CNBModels' }
FamixStClass >> print [ 

	^ (CNBClassHierarchyPrinter new forClass: (Smalltalk image classNamed: self name)) print  
	
]

{ #category : #'*CNBModels' }
FamixStClass >> rootAccordingTo: aRootClassName [

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
