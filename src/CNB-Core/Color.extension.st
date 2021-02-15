Extension { #name : #Color }

{ #category : #'*CNB-Core' }
Color >> isMonoSuffixColor [ 
	^ self = self class gray
]
