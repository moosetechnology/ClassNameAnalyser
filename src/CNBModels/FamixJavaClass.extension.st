Extension { #name : #FamixJavaClass }

{ #category : #'*CNBModels' }
FamixJavaClass >> classDepthAccordingTo: aRootName [

	" We use name since the input is in a text field"
     (self isTrait 
		or: [ self name = aRootName 
			or:  [ self superClass isNil ] ]) ifTrue: [ ^ 1 ].
   
	(self superClass name = aRootName 
                or: [ self superClass name = Object name ]) ifTrue: [ ^ 1 ].
      
    ^ (self superClass classDepthAccordingTo: aRootName) + 1
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
FamixJavaClass >> print [

	^ (CNBClassHierarchyPrinter forFamixClass: self) print
]

{ #category : #'*CNBModels' }
FamixJavaClass >> rootAccordingTo: aRootClassName [

	 (self isTrait 
		or: [ self name = aRootClassName 
			or:  [ self superClass isNil ] ]) ifTrue: [ ^ self ].
   
	(self superClass name = aRootClassName 
                or: [ self superClass name = Object name ]) ifTrue: [ ^ self ].
      
    ^ self superClass rootAccordingTo: aRootClassName
]

{ #category : #'*CNBModels' }
FamixJavaClass >> superClass [

	| superClasses |
	superClasses := self superInheritances collect: #superclass.
	superClasses ifEmpty: [ ^ nil ].

	"returns the class"
	^ superClasses
		  detect: #isClass
		  ifNone: [ "if not found: checks classes of the parameterizedTypes, rejects the interfaces and selects a class. 
	But what if there were more than one parameterizedClass"
			  (((superClasses select: #isParameterizedType) collect:
				    #parameterizableClass) reject: #isInterface)
				  detect: #isClass
				  ifNone: [ nil ] ]
]
