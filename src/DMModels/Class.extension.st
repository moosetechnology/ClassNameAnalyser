Extension { #name : #Class }

{ #category : #'*DMModels' }
Class >> classmodel [

	^DMClassModel new 
	name: self name;
	root: self root;
	level: self hierarchyLevel;
	concept: self name;
	reference: self;
	superclass: self superclass
	
	
]

{ #category : #'*DMModels' }
Class >> submodels [

	^(self subclasses collect: [ :each |  
		(DMClassModel new 
		name: each name;
		level: each hierarchyLevel;
		reference: each;
		root: each root;
		superclass: each superclass;
		concept: each name)]) asSet
]
