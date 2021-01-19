Extension { #name : #ProtoObject }

{ #category : #'*DMModels' }
ProtoObject >> classDepth [
	"To work with FamixStClasses"
	self superclass ifNil: [^ 1].
	^ (self superclass classDepth + 1) 
]

{ #category : #'*DMModels' }
ProtoObject >> classModelAccordingTo: aMotherClass [

	^	DMClassModel new 
							reference: self;
							name: self name;
							root: (self rootAccordingTo: aMotherClass);
							superclass: self superclass;
							concept: (DMFeatureSelector new extractConceptFrom: self name)
]

{ #category : #'*DMModels' }
ProtoObject >> classmodel [

	^(DMClassModel new 
	name: self name;
	level: self classDepth - 1;
	concept: self name;
	reference: self;
	superclass: self superclass)
	
	
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
	^ self superclass rootAccordingTo: aMotherClass 
	
]
