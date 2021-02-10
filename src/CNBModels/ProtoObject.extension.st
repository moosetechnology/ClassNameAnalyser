Extension { #name : #ProtoObject }

{ #category : #'*CNBModels' }
ProtoObject >> classDepth [
	"To work with FamixStClasses"
	self superclass ifNil: [^ 1].
	^ (self superclass classDepth + 1) 
]

{ #category : #'*CNBModels' }
ProtoObject >> classModelAccordingTo: aMotherClass [

	^	CNBClassModel new 
							reference: self;
							name: self name;
							root: (self rootAccordingTo: aMotherClass);
							superclass: self superclass;
							concept: (DMFeatureSelector new extractSuffixFrom: self name)
]

{ #category : #'*CNBModels' }
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
