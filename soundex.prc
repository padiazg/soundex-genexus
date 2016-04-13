//parm(in:&texto, out:&soundex)

&soundex.SetEmpty()
&tmp = &texto.Trim().ToUpper()

// retornar vacío si recibimos un texto vacío o solo espacios
if &tmp.IsEmpty()
    return
endif

do 'limpieza'
do 'soundex'

Sub 'limpieza'
    /*     1) limpieza     */
    // eliminamos la H inicial (incluso si hay mas de una)
    &tmp = &tmp.ReplaceRegEx('^(H+)(.*)', '$2')

    // retornar vacío si no nos queda texto para analizar
    if &tmp.IsEmpty()
        return
    endif

    // eliminamos los acentos y la Ñ
    &caracteres_buscar     = 'ÑÁÉÍÓÚÀÈÌÒÙÜ'
    &caracteres_reemplazar = 'NAEIOUAEIOUU'
    for &i=1 to &caracteres_buscar.Length()
        &caracter = &caracteres_buscar.Substring(&i,1)
        if &caracteres_buscar.IndexOf(&caracter)>0
            &tmp = &tmp.Replace(&caracter, &caracteres_reemplazar.Substring(&i, 1))
        endif // &buscar.IndexOf(&caracter)>0
    endfor // &i=1 to &buscar.Length() ...

    // eliminamos caracteres no alfabéticos (números, signos, símbolos, etc)
    &tmp = &tmp.ReplaceRegEx('[^A-Z]', '')

    /*     2) ajustar primera letra    */   
    // fenómenos o casos especiales: GE y GI se convierten en JE y JI, CA en KA
    &primera_letra = &tmp.Substring(1,1)
    &resto = &tmp.Substring(2,&tmp.Length()-1) 

    do case
        case &primera_letra = 'V'
            &reemplazo = 'B'        // VACA -> BACA, VALOR -> BALOR

        case &primera_letra = 'Z' or &primera_letra = 'X'
            &reemplazo = 'S'        // ZAPATO -> SAPATO, XILÓFONO -> SILÓFONO

        case &primera_letra = 'G'
            and (&tmp.Substring(2,1)='E' or &tmp.Substring(2,1)='I')
            &reemplazo = 'J'        // GIMNASIO -> JIMNASIO, GERANIO -> JERANIO

        case &primera_letra = 'C'
            and &tmp.Substring(2,1)<>'H'
            and &tmp.Substring(2,1)<>'E'
            and &tmp.Substring(2,1)<>'I'
            &reemplazo = 'K'        // CASA -> KASA, COLOR -> KOLOR, CULPA -> KULPA

        otherwise
            &reemplazo = &primera_letra

    endcase

    &tmp = &reemplazo + &resto

    /*     3) corregir letras compuestas, volverlas una sola    */
    &tmp = &tmp.ReplaceRegEx('CH', 'V')
    &tmp = &tmp.ReplaceRegEx('QU', 'K')
    &tmp = &tmp.ReplaceRegEx('LL', 'J')
    &tmp = &tmp.ReplaceRegEx('CE', 'S')
    &tmp = &tmp.ReplaceRegEx('CI', 'S')
    &tmp = &tmp.ReplaceRegEx('YA', 'J')
    &tmp = &tmp.ReplaceRegEx('YE', 'J')
    &tmp = &tmp.ReplaceRegEx('YI', 'J')
    &tmp = &tmp.ReplaceRegEx('YO', 'J')
    &tmp = &tmp.ReplaceRegEx('YU', 'J')
	//&tmp = &tmp.ReplaceRegEx('GE', 'J')
	//&tmp = &tmp.ReplaceRegEx('GI', 'J')
    &tmp = &tmp.ReplaceRegEx('NY', 'N')
    &tmp = &tmp.ReplaceRegEx('NH', 'N') // anho, banho, tamanho, inhalador
EndSub // 'limpieza' ...

Sub 'soundex'

    /* 4) obtener primera letra        */
    &primera_letra = &tmp.Substring(1, 1)
   
    /* 5) obtener el resto del texto    *
    &resto = &tmp.Substring(2, &tmp.Length()-1)
   
    /* 6) en el resto, eliminar vocales y consonantes fonéticas        */
    &resto = &resto.ReplaceRegEx('[AEIOUHWY]', '')

    /* 7) convertir letras fonéticamente equivalentes a números. esto hace que B sea equivalente a V, C con S y Z, etc.    */
    &resto = &resto.ReplaceRegEx('[BPFV]',   '1')
    &resto = &resto.ReplaceRegEx('[CGKSXZ]', '2')
    &resto = &resto.ReplaceRegEx('[DT]',     '3')
    &resto = &resto.ReplaceRegEx('[L]',      '4')
    &resto = &resto.ReplaceRegEx('[MN]',     '5')
    &resto = &resto.ReplaceRegEx('[R]',      '6')
    &resto = &resto.ReplaceRegEx('[QJ]',     '7')

    // eliminamos números iguales adyacentes
    &resto = &resto.ReplaceRegEx('(\d)\1+', '$1') 
    &soundex = &primera_letra + &resto.Trim()
    if &soundex.Length() < 4
        &soundex = padr(&soundex, 4, '0')
    else
        &soundex = &soundex.Substring(1,4)
    endif
	
EndSub // 'soundex' ...