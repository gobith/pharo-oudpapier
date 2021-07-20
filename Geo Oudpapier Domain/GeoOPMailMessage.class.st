Class {
	#name : #GeoOPMailMessage,
	#superclass : #Object,
	#instVars : [
		'schedule',
		'user',
		'mailMessage',
		'errorString'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPMailMessage >> action [

	^self subclassResponsibility 
]

{ #category : #accessing }
GeoOPMailMessage >> html [
	| canvas |
	canvas := GeoHtmlCanvas new.
	self renderOn: canvas.
	^ canvas htmlString
]

{ #category : #initialization }
GeoOPMailMessage >> initialize [

	super initialize.
	mailMessage := MailMessage empty.
	
]

{ #category : #accessing }
GeoOPMailMessage >> mailMessage [
	^ mailMessage
]

{ #category : #accessing }
GeoOPMailMessage >> mailMessage: anObject [
	mailMessage := anObject
]

{ #category : #rendering }
GeoOPMailMessage >> renderOn: aCanvas [
]

{ #category : #accessing }
GeoOPMailMessage >> schedule [
	^ schedule
]

{ #category : #accessing }
GeoOPMailMessage >> schedule: anObject [
	schedule := anObject
]

{ #category : #actions }
GeoOPMailMessage >> send [
	mailMessage setField: 'subject' toString: self subjectString.
	mailMessage addMixedPart: self html contentType: 'text/html'.
	
	errorString := 'succes'.
	
	[self sendMessage] on: Error do: [: ex | errorString := ex messageText ].

	self action doIt
]

{ #category : #sending }
GeoOPMailMessage >> sendMessage [
	| smtpClient senderAddress receiverAddress |
	
	senderAddress := schedule senderAddress.
	receiverAddress := user email.
	
	(smtpClient := ZdcSecureSMTPClient new)
		user: senderAddress;
		password: schedule mailPassword.
	smtpClient openOnHost: (NetNameResolver addressForName: schedule smptServerString) port: ZdcSecureSMTPClient defaultPortForSSL.
	mailMessage setField: 'from' toString: senderAddress.
	mailMessage setField: 'to' toString: receiverAddress.
	^ smtpClient
		mailFrom: senderAddress
			to:
			{receiverAddress. senderAddress}
			text: mailMessage text;
		quit;
		close;
		yourself
]

{ #category : #accessing }
GeoOPMailMessage >> subjectString [

	self subclassResponsibility 
]

{ #category : #accessing }
GeoOPMailMessage >> user [
	^ user
]

{ #category : #accessing }
GeoOPMailMessage >> user: anObject [
	user := anObject
]
