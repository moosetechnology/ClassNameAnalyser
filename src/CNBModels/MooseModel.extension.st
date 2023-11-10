Extension { #name : #MooseModel }

{ #category : #'*CNBModels' }
MooseModel >> packages [

	^ (self allModelPackages ifNil: [ self allModelNamespaces ])
		  ifEmpty: self allModelNamespaces
]
