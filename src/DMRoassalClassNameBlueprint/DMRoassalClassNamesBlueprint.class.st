Class {
	#name : #DMRoassalClassNamesBlueprint,
	#superclass : #Object,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassalClassNamesBlueprint >> visualize: aViewModel [
	
 | b |
	b := RTMondrian new.
	b shape rectangle 
	withTextAbove: [ :packageVM | DMNameAbbreviationCreator abbreviate: packageVM name until: 3  ] color: Color white;
	borderColor: Color black;
	color: Color white darker.
	b interaction popup 
		text: [ :aPackageVM | aPackageVM name ].
	b
		nodes: ((aViewModel models sorted: #size descending) collect: [ :packageVM | packageVM ] )
		forEach: [ :pVM | 
			b shape rectangle 
			color: [ :eachConcept |  Color value: eachConcept color  ];
			withTextAbove: [ :cpt | cpt name ] color: Color darkGray.
			b interaction popup 
					text: [ :conceptVM | 'Concept: ' , conceptVM name ].
			b nodes: (pVM models collect: [ :conceptVM | conceptVM ])
			forEach: [ :conceptVM | 
				b shape rectangle 
				color: [ :classVM | Color value: classVM color ];
				borderColor: [ :aClassVM | aClassVM borderColor ].
				b nodes: (conceptVM models collect: [ :aClassVm | aClassVm ] ).
				b layout grid.
			  ].
		b layout grid
		].
b layout flow.
b build.
^ b view.
]
