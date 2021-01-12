Extension { #name : #Class }

{ #category : #'*DMModels' }
Class >> submodels [

	^(self subclasses collect: [ :each |  
		(DMClassModel new 
		name: each name;
		level: each classDepth;
		reference: each;
		root: each rootClass;
		superclass: each superclass;
		concept: each name)]) asSet
]
