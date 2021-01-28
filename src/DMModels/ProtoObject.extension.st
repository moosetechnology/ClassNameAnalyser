Extension { #name : #ProtoObject }

{ #category : #'*DMModels' }
ProtoObject >> classDepth [
	"To work with FamixStClasses"
	self superclass ifNil: [^ 1].
	^ (self superclass classDepth + 1) 
]

{ #category : #'*DMModels' }
ProtoObject >> classModelAccordingTo: aMotherClass [
	^ DMClassModel new
		reference: self;
		name: self name;
		root: (self rootAccordingTo: aMotherClass);
		superclass:
			(self superclass class = 'FAMIXParameterizedType'
				ifTrue: [ self superclass parameterizableClass ]
				ifFalse: [ self superclass ]);
		concept: self name.
]

{ #category : #'*DMModels' }
ProtoObject >> rootAccordingTo: aMotherClass [

	self isTrait
		ifTrue: [ ^ self ].
	(aMotherClass = self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = aMotherClass name
		ifTrue: [ ^ self ].
	self superclass isInterface 
		ifTrue: [ ^self ].
	^(self superclass class = FAMIXParameterizedType
	ifTrue: [ self superclass parameterizableClass] 
	ifFalse: [self superclass rootAccordingTo: aMotherClass])
	
]
