Class {
	#name : #DMColorPalette,
	#superclass : #QualitativeColorPalette,
	#category : #DMBuilder
}

{ #category : #examples }
DMColorPalette class >> show [
	<example>
	self new inspect
]

{ #category : #accessing }
DMColorPalette >> colorOfMonoClass [
	^ Color fromHexString: #e8e8e8
]

{ #category : #accessing }
DMColorPalette >> colorOfMonoSuffix [
	^ Color fromHexString: #'808080'
]

{ #category : #accessing }
DMColorPalette >> colorOfTrait [
	^ Color fromHexString: #e8e8e8
]

{ #category : #accessing }
DMColorPalette >> defaultColor [
	^ Color fromHexString: #'000000'
]

{ #category : #accessing }
DMColorPalette >> rgbValues [
	^ #(
		(1.0                 0.0                 0.0                )
		(1.0                 1.0                 0.0                )
		(0.0                 0.0 					 1.0                )
		(0.0                 1.0                 0.0                )
		(1.0                 0.49803921568627452 0.0                )	
		(1.0                 0.0                 1.0                )
		(0.0                 1.0                 1.0                )
		(1.0                 0.7529411764705882  0.796078431372549  )
		(1.0                 0.8980392156862745  0.7058823529411765 )
		(0.6980392156862745  0.8745098039215686  0.5411764705882353 )
		(0.65098039215686276 0.33725490196078434 0.15686274509803921)
		(0.5019607843137255  0.0                 0.0                )   
		(0.5019607843137255  0.0                 0.5019607843137255 )
		(0.5607843137254902  0.48627450980392156 0.0                )
		(0.21568627450980393 0.49411764705882355 0.72156862745098038)
	)
]
