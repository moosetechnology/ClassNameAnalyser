Extension { #name : #Class }

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
