Extension { #name : #FamixStModel }

{ #category : #'*DMModels' }
FamixStModel >> buildConceptualModel [
	^ DMBuilder buildConceptualModelFrom: (self allModelPackages ifNil: self allModelNamespaces ) asMooseGroup 

]
