Extension { #name : #FamixTClass }

{ #category : #'*DMConceptualModel' }
FamixTClass >> classmodel [
	
	 DMHierarchy add: (self root name).
	^DMClassModel new 
	name: self name;
	concept: self name;
	level: self level;
	root: self root name.

]

{ #category : #'*DMConceptualModel' }
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

{ #category : #'*DMConceptualModel' }
FamixTClass >> root [

	(self isTrait) 
	ifTrue: [ ^self ].
	
	({'ProtoObject' . 'Object'} includes: self name)
	ifTrue: [ ^self ].
	
	(self superclass name = 'Object')
	ifTrue: [ ^self ].
	
	^self superclass root
	
]

{ #category : #'*DMConceptualModel' }
FamixTClass >> rootmodel [

	
	^DMRootModel new
	name: self root name;
	concept: self root name.
	
	
]

{ #category : #'*DMConceptualModel' }
FamixTClass >> submodels [

	^(DMClassModelGroup new addAll: (self subclasses collect: [ :each | each classmodel ]))
]

{ #category : #'*DMConceptualModel' }
FamixTClass >> superclassmodel [

	
	^self superclass classmodel ifNil: [ ^self classmodel ]
]

{ #category : #'*DMConceptualModel' }
FamixTClass >> type [ 

	self isTrait
	ifTrue: [ ^ #Trait ].
	
	self subclasses isEmpty 
	ifTrue: [ ^ #monoClass ].
	
	((self submodels collect: [ :each | each concept ] asSet) equals: 1)
	ifTrue: [ ^ #monoSuffix ].
	
	^ #multiSuffix
]
