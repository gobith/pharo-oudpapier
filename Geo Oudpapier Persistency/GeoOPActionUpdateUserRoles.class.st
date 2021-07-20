Class {
	#name : #GeoOPActionUpdateUserRoles,
	#superclass : #GeoOPAction,
	#instVars : [
		'user',
		'websiteRoleString',
		'roleString'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionUpdateUserRoles class >> headerString [

	^'UpdateUserRoles'
]

{ #category : #actions }
GeoOPActionUpdateUserRoles >> doIt [
	| websiteRole role |
	websiteRole := GeoOPUserWebsiteRole fromString: websiteRoleString.
	role := GeoOPUserRole fromString: roleString.
	user
		websiteRole: websiteRole;
		role: role.
	self persist
]

{ #category : #actions }
GeoOPActionUpdateUserRoles >> fileIn [
	| websiteRole role |
	user := schedule userAt: (substrings at: 3) asInteger.
	websiteRoleString := substrings at: 4.
	roleString := substrings at: 5.
	websiteRole := GeoOPUserWebsiteRole fromString: websiteRoleString.
	role := GeoOPUserRole fromString: roleString.
	user
		websiteRole: websiteRole;
		role: role.
	self addToSchedule
]

{ #category : #persistence }
GeoOPActionUpdateUserRoles >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		print: user id;
		nextPut: self separator;
		nextPutAll: websiteRoleString ;
		nextPut: self separator;
		nextPutAll: roleString.
	^ ws contents
]

{ #category : #printing }
GeoOPActionUpdateUserRoles >> prettyStringOn: ws [

	super prettyStringOn: ws.
	ws tab; nextPutAll: user name
]

{ #category : #accessing }
GeoOPActionUpdateUserRoles >> roleString [
	^ roleString
]

{ #category : #accessing }
GeoOPActionUpdateUserRoles >> roleString: anObject [
	roleString := anObject
]

{ #category : #accessing }
GeoOPActionUpdateUserRoles >> user [
	^ user
]

{ #category : #accessing }
GeoOPActionUpdateUserRoles >> user: anObject [
	user := anObject
]

{ #category : #accessing }
GeoOPActionUpdateUserRoles >> websiteRoleString [
	^ websiteRoleString
]

{ #category : #accessing }
GeoOPActionUpdateUserRoles >> websiteRoleString: anObject [
	websiteRoleString := anObject
]
