Extension { #name : #Collection }

{ #category : #'*Geo Oudpapier Domain' }
Collection >> maxValue: aBlock [
	^ self inject: (aBlock value: self anyOne) into: [ :max :each | max max: (aBlock value: each) ]
]
