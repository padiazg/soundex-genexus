/*
	Colocar los siguientes valores en las propiedades del procedimiento
	-------------------------------------------------------------------
	Main program: true
	Call protocol: Command Line
*/

msg('hola => ' + soundex.Udp('hola'), status)			// hola => O400
msg('ola => ' + soundex.Udp('ola'), status)				// ola => O400

msg('zapato => ' + soundex.Udp('zapato'), status)		// zapato => S130
msg('sapato => ' + soundex.Udp('sapato'), status)		// sapato => S130

msg('Jimenez => ' + soundex.Udp('Jimenez'), status) 	// Jimenez => J520
msg('Jiménez => ' + soundex.Udp('Jiménez'), status)		// Jiménez => J520
msg('Jimenes => ' + soundex.Udp('Jimenes'), status)		// Jimenes => J520
msg('Jiménes => ' + soundex.Udp('Jiménes'), status)		// Jiménes => J520
msg('Gimenez => ' + soundex.Udp('Gimenez'), status)		// Gimenez => J520
msg('Giménez => ' + soundex.Udp('Giménez'), status)		// Giménez => J520
msg('Gimenes => ' + soundex.Udp('Gimenes'), status)		// Gimenes => J520
msg('Giménes => ' + soundex.Udp('Giménes'), status)		// Giménes => J520

msg('Díaz => ' + soundex.Udp('Díaz'), status)			// Díaz => D200
msg('días => ' + soundex.Udp('días'), status)			// días => D200
msg('dias => ' + soundex.Udp('dias'), status)			// dias => D200

msg('mejico => ' + soundex.Udp('mejico'), status)		// mejico => M720
msg('mexico => ' + soundex.Udp('mexico'), status)		// mexico => M200
