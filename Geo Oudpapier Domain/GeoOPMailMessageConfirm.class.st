Class {
	#name : #GeoOPMailMessageConfirm,
	#superclass : #GeoOPMailMessage,
	#instVars : [
		'partTime'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPMailMessageConfirm >> action [
	| action |
	action := GeoOPActionConfirmMailPerUser new.
	action
		schedule: schedule;
		partTime: partTime;
		user: user;
		errorString: errorString.
	^ action
]

{ #category : #accessing }
GeoOPMailMessageConfirm >> partTime [
	^ partTime
]

{ #category : #accessing }
GeoOPMailMessageConfirm >> partTime: anObject [
	partTime := anObject
]

{ #category : #rendering }
GeoOPMailMessageConfirm >> renderOn: aCanvas [
	aCanvas body p << ('Hallo <1s>,' expandMacrosWith: user firstName).
	aCanvas body p
		<< [ :p | 
			p << 'Je bent ingepland op'.
			p bold
				<< [ :b | 
					b << partTime dateString.
					b << ' '.
					b << partTime postFixString ] ].
	(aCanvas body p anchor
		href: ('<1s>/confirm/<2p>/<3s>' expandMacrosWith: schedule websiteUrl with: user id with: partTime dateAndtimeString))
		<< 'Druk hier om te bevestigen'.
	aCanvas body p << 'Alvast bedankt,'.
	aCanvas body p << 'Georges en Rene'.
	aCanvas body p
		<<
			'ps Als het niet lukt om te bevestigen of als je verhinderd bent laat het ons zo spoedig mogelijk weten d.m.v. een reply op deze mail'
]

{ #category : #accessing }
GeoOPMailMessageConfirm >> subjectString [

	^'Oud Papier Bevestigen <1s>' expandMacrosWith: partTime prettyString
]
