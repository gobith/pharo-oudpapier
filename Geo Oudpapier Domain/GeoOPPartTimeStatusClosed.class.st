Class {
	#name : #GeoOPPartTimeStatusClosed,
	#superclass : #GeoOPPartTimeStatus,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPPartTimeStatusClosed >> buttonString [

	^'Sluit'
]

{ #category : #testing }
GeoOPPartTimeStatusClosed >> canSendMail [

	^true
]

{ #category : #testing }
GeoOPPartTimeStatusClosed >> isClosed [

	^true
]

{ #category : #accessing }
GeoOPPartTimeStatusClosed >> nextStatus [

	^GeoOPPartTimeStatusFinished singleInstance
]

{ #category : #visiting }
GeoOPPartTimeStatusClosed >> scheduleImageFor: aStatus [

	^aStatus scheduleImageClosed
]

{ #category : #visiting }
GeoOPPartTimeStatusClosed >> scheduleStringFor: aStatus [

	^aStatus scheduleStringClosed
]

{ #category : #accessing }
GeoOPPartTimeStatusClosed >> statusString [

	^'Gesloten'
]

{ #category : #accessing }
GeoOPPartTimeStatusClosed >> statusSymbol [

	^#closed
]
