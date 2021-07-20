Class {
	#name : #GeoOPUserWebsiteAdminRole,
	#superclass : #GeoOPUserWebsiteRole,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserWebsiteAdminRole class >> roleName [

	^'Admin'
]

{ #category : #accessing }
GeoOPUserWebsiteAdminRole class >> roleString [

	^'admin'
]

{ #category : #testing }
GeoOPUserWebsiteAdminRole >> isAdmin [

	^true
]
