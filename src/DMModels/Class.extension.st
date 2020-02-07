Extension { #name : #Class }

{ #category : #'*DMModels' }
Class >> classmodel [

	^DMClassModel new 
	name: self name;
	root: self rootclass;
	level: self level;
	concept: self name;
	reference: self;
	superclass: self superclass
	
	
]

{ #category : #'*DMModels' }
Class >> level [ 

	| c depth |	
	depth := 0.	
	c := self superclass.
	
	[c isNil]		
	whileFalse: [ 
			depth := depth + 1.
			c := c superclass.
		 ].
	^depth-1
]

{ #category : #'*DMModels' }
Class >> rootclass [

	self isTrait
		ifTrue: [ ^ self ].
	({'ProtoObject' . 'Object'} includes: self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = 'Object'
		ifTrue: [ ^ self ].
	^ self superclass root
	
]

{ #category : #'*DMModels' }
Class >> submodels [

	^(self subclasses collect: [ :each |  
		(DMClassModel new 
		name: each name;
		level: self level;
		reference: self;
		root: self rootclass;
		concept: self name)]) asSet
]
