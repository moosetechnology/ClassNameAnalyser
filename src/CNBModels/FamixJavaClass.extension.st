Extension { #name : #FamixJavaClass }

{ #category : #'*CNBModels' }
FamixJavaClass >> classDepthAccordingTo: aRootName [
	" We use name since the input is in a text field"
    |superclass|
    superclass := ((self superInheritances collect: #target) reject: #isInterface).

    (self isTrait or: [ self name = aRootName  ])
        ifTrue: [ ^ 1 ].
        
    (superclass isEmpty 
			or: [ superclass first name = aRootName
				 or: [ superclass first name = Object name ] ])
        ifTrue: [ ^ 1 ].
        
    ^ (superclass first classDepthAccordingTo: aRootName) + 1
]

{ #category : #'*CNBModels' }
FamixJavaClass >> classModelAccordingTo: setting [

	^ CNBClassModel of: self accordingTo: setting

]

{ #category : #'*CNBModels' }
FamixJavaClass >> exists [ 

	^ false
]

{ #category : #'*CNBModels' }
FamixJavaClass >> isMono [ 

	^ self superclass = Object 
]

{ #category : #'*CNBModels' }
FamixJavaClass >> print [ 

	^ (CNBClassHierarchyPrinter new forClass: self) printFamixJava 
]

{ #category : #'*CNBModels' }
FamixJavaClass >> rootAccordingTo: aRootClassName [

    |superclass|
    superclass := ((self superInheritances collect: #target) reject: [:c | c isClass not or: [c isInterface]]).

    (self isTrait or: [ self name = aRootClassName ])
        ifTrue: [ ^ self ].
        
    (superclass isEmpty 
            or: [ superclass first name = aRootClassName 
                or: [ superclass first name = Object name ] ])
        ifTrue: [ ^ self ].
        
    ^ superclass first rootAccordingTo: aRootClassName
]
