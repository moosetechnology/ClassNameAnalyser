Class {
	#name : #DMRoassalClassNameBlueprint,
	#superclass : #Object,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #Visualisation }
DMRoassalClassNameBlueprint >> visualise: aViewModel [

	| b |
	b := RTMondrian new.
	b shape rectangle withTextAbove: [ :packageVM | packageVM packageName ].
	b 
		nodes: (aViewModel packageViewModels collect: [ :packageVM | packageVM ])
		forEach: [ :pVM | 
			b shape rectangle
			color: [ :each | Color value: each color ].
			b nodes: (pVM conceptViewModels collect: [ :conceptVM | conceptVM ])
			forEach: [ :conceptVM | 
				b shape rectangle
				color: [ :e | Color value: e color ].
				b nodes: (conceptVM classViewModels collect: [ :classVm |classVm  ])   
			 ].
		b layout flow.
		 ]. 
b layout flow.
b build.
^ b view.

]
