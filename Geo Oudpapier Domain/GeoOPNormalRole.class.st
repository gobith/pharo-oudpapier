Class {
	#name : #GeoOPNormalRole,
	#superclass : #GeoOPUserRole,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPNormalRole class >> roleName [

	^'Normaal'
]

{ #category : #accessing }
GeoOPNormalRole class >> roleString [

	^'normal'
]

{ #category : #testing }
GeoOPNormalRole >> isNormal [

	^true
]
