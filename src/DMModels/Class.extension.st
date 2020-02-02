Extension { #name : #Class }

{ #category : #'*DMModels' }
Class >> submodels [

	^(self subclasses collect: [ :each |  
		(DMClassModel new 
		name: each name;
		level: self level;
		reference: self;
		root: self root;
		concept: self name)]) asSet
]
