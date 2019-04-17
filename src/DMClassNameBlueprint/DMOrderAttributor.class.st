Class {
	#name : #DMOrderAttributor,
	#superclass : #Object,
	#instVars : [
		'orderFromBiggest',
		'orderFromSmallest'
	],
	#category : #DMClassNameBlueprint
}

{ #category : #accessing }
DMOrderAttributor >> orderFromBiggest [ 
	^orderFromBiggest 
]

{ #category : #accessing }
DMOrderAttributor >> orderFromBiggest: aBoolean [
	orderFromBiggest := aBoolean 
]

{ #category : #accessing }
DMOrderAttributor >> orderFromSmallest [ 
	^orderFromSmallest 
]

{ #category : #accessing }
DMOrderAttributor >> orderFromSmallest: aBoolean [
	orderFromSmallest := aBoolean
]

{ #category : #initialization }
DMOrderAttributor >> setOrder: aViewModel [

	(orderFromBiggest)
		ifTrue: [ ^ self setOrderFromBiggest: aViewModel  ].
	
	(orderFromSmallest)
		ifTrue: [ ^ self setOrderFromSmallest: aViewModel  ].
		
	^aViewModel 
]

{ #category : #initialization }
DMOrderAttributor >> setOrderFromBiggest: aViewModel [








	^aViewModel 
]

{ #category : #initialization }
DMOrderAttributor >> setOrderFromSmallest: aViewModel [
			
		
	




	^aViewModel 
]
