Extension { #name : #FamixTClass }

{ #category : #'*DMConceptualModel' }
FamixTClass >> classmodel [
	
	 DMHierarchy add: (self rootOf: self).
	^DMClassModel new 
	name: self name;
	concept: self name;
	"level: self level;"
	root: self rootmodel;
	superclass: self superclassmodel
]

{ #category : #'*DMConceptualModel' }
FamixTClass >> level [ 

	(self isTrait) 
	ifTrue: [ ^self ].
	
	({'ProtoObject' . 'Object'} includes: self name)
	ifTrue: [ ^self ].
	
	(self superclass name = 'Object')
	ifTrue: [ ^self ].
	
	self rootOf: (self superclass )
	

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
	"subclasses: root submodels;
	type: self root type;
	color: self root color."
	
]

{ #category : #'*DMConceptualModel' }
FamixTClass >> submodels [

	^(DMClassModelGroup new addAll: (self subclasses collect: [ :each | each classmodel ]))
]

{ #category : #'*DMConceptualModel' }
FamixTClass >> superclassmodel [

	(self superclass) 
	ifNotNil: [ ^ (self superclass) classmodel ].
	
	^self classmodel
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
