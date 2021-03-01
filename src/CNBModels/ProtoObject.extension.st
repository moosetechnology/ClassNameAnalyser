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
							suffix: (CNBFeatureSelector new extractSuffixFrom: self name);
							prefix: (CNBFeatureSelector new extractPrefixFrom: self name)
]

{ #category : #'*CNBModels' }
ProtoObject >> rootAccordingTo: aRootClassName [

	self isTrait
		ifTrue: [ ^ self ].
	(aRootClassName = self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = aRootClassName
		ifTrue: [ ^ self ].
	^ self superclass rootAccordingTo: aRootClassName 
	
]
