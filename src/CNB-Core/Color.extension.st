Extension { #name : #Color }

{ #category : #'*CNB-Core' }
Color >> isMonoClassColor [ 

	^ self = self class white
]

{ #category : #'*CNB-Core' }
Color >> isMonoTokenColor [ 

	^ self = self class gray
]
