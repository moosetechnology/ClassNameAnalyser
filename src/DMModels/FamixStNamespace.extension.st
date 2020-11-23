Extension { #name : #FamixStNamespace }

{ #category : #'*DMModels' }
FamixStNamespace >> classmodels [
	^self classes collect: [ :each | each classmodel ]
]

{ #category : #'*DMModels' }
FamixStNamespace >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMModels' }
FamixStNamespace >> packagemodel [

	^DMPackageModel new 
	name: self name;
	classmodels: self conceptualClassModels  
]
