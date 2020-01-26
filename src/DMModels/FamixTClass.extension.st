Extension { #name : #FamixTClass }

{ #category : #'*DMModels' }
FamixTClass >> classmodel [
	
	 DMHierarchy add: (self root).
	^DMClassModel new 
	name: self name;
	concept: self name;
	level: self level;
	root: self root.

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

{ #category : #'*DMModels' }
FamixTClass >> rootmodel [

	
	^DMRootModel new
	name: self root name;
	concept: self root name.
	
	
]

{ #category : #'*DMModels' }
FamixTClass >> submodels [

	^(DMClassModelGroup new addAll: (self subclasses collect: [ :each | each classmodel ]))
]

{ #category : #'*DMModels' }
FamixTClass >> superclassmodel [

	
	^self superclass classmodel ifNil: [ ^self classmodel ]
]

{ #category : #'*DMModels' }
FamixTClass >> type [ 

	self isTrait
	ifTrue: [ ^ #Trait ].
	
	self subclasses isEmpty 
	ifTrue: [ ^ #monoClass ].
	
	((self submodels collect: [ :each | each concept ] asSet) equals: 1)
	ifTrue: [ ^ #monoSuffix ].
	
	^ #multiSuffix
]
