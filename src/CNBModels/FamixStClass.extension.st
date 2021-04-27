Extension { #name : #FamixStClass }

{ #category : #'*CNBModels' }
FamixStClass >> classDepthAccordingTo: aRootName [

 (self isTrait 
		or: [ self name = aRootName 
			or:  [ self superclass isNil ] ]) ifTrue: [ ^ 1 ].
   
	(self superclass name = aRootName 
                or: [ self superclass name = Object name ]) ifTrue: [ ^ 1 ].
      
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
FamixStClass >> printWithBold: aStringOrText [

	^ (CNBClassHierarchyPrinter new 
			forClass: (Smalltalk image classNamed: self name)) printWithBoldPharoClass: aStringOrText 
	
]

{ #category : #'*CNBModels' }
FamixStClass >> rootAccordingTo: aRootClassName [

	 (self isTrait 
		or: [ self name = aRootClassName 
			or:  [ self superclass isNil ] ]) ifTrue: [ ^ self ].
   
	(self superclass name = aRootClassName 
                or: [ self superclass name = Object name ]) ifTrue: [ ^ self ].
      
    ^ self superclass rootAccordingTo: aRootClassName
	

	
]
