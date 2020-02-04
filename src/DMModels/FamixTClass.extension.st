Extension { #name : #FamixTClass }

{ #category : #'*DMModels' }
FamixTClass >> classmodel [
	
	 DMHierarchy add: (self root).
	^DMClassModel new 
	name: self name;
	concept: self name;
	level: self level;
	root: self root;
	reference: self.

]

{ #category : #'*DMModels' }
FamixTClass >> level [ 

	| c depth |	
	depth := 0.	
	c := self superclass.
	
	[c isNil]		
	whileFalse: [ 
			depth := depth + 1.
			c := c superclass.
		 ].
	^depth
]

{ #category : #'*DMModels' }
FamixTClass >> root [

	(self isTrait) 
	ifTrue: [ ^self ].
	
	({'ProtoObject' . 'Object'} includes: self name)
	ifTrue: [ ^self ].
	
	(self superclass name = 'Object')
	ifTrue: [ ^self ].
	
	^self superclass root
	
]
