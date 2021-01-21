Extension { #name : #FamixStModel }

{ #category : #'*DMModels' }
FamixStModel >> packages [ 
	^	(self allModelPackages ifNil: self allModelNamespaces) asMooseGroup.
]
