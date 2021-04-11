Extension { #name : #FamixJavaParameterizedType }

{ #category : #'*CNBModels' }
FamixJavaParameterizedType >> classDepthAccordingTo: aRootName [
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
FamixJavaParameterizedType >> exists [ 

	^ false
]

{ #category : #'*CNBModels' }
FamixJavaParameterizedType >> rootAccordingTo: aRootClassName [

    |superclass|
    superclass := ((self superInheritances collect: #target) reject: #isInterface).

    (self isTrait or: [ self name = aRootClassName ])
        ifTrue: [ ^ self ].
        
    (superclass isEmpty 
			or: [ superclass first name = aRootClassName 
				or: [ superclass first name = Object name ] ])
        ifTrue: [ ^ self ].
        
    ^ superclass first rootAccordingTo: aRootClassName
]
