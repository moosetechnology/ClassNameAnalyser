Extension { #name : #Behavior }

{ #category : #'*DMModels' }
Behavior >> classmodel [

	^(DMClassModel new 
	name: self name;
	root: self rootClass;
	level: self hierarchyLevel;
	concept: self name;
	reference: self;
	superclass: self superclass)
	
	
]

{ #category : #'*DMModels' }
Behavior >> hierarchyLevel [ 

	"| c depth |	
	depth := 0.	
	c := self superclass.
	
	[c isNil]		
	whileFalse: [ 
			depth := depth + 1.
			c := c superclass.
		 ].
	^depth"
]

{ #category : #'*DMModels' }
Behavior >> rootClass [

	self isTrait
		ifTrue: [ ^ self ].
	({'ProtoObject' . 'Object'} includes: self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = 'Object'
		ifTrue: [ ^ self ].
	^ self superclass rootClass
	
]
