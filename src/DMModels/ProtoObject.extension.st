Extension { #name : #ProtoObject }

{ #category : #'*DMModels' }
ProtoObject >> classDepth [
	"To work with FamixStClasses"
	self superclass ifNil: [^ 1].
	^ (self superclass classDepth + 1) 
]

{ #category : #'*DMModels' }
ProtoObject >> classmodel [

	^(DMClassModel new 
	name: self name;
	root: self root;
	level: self classDepth - 1;
	concept: self name;
	reference: self;
	superclass: self superclass)
	
	
]

{ #category : #'*DMModels' }
ProtoObject >> root [

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
