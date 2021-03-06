unit SICK013;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB, CheckLst, wintypes, winprocs, gauges;

type
  TCONSISTEINSCRICAOESTADUAL  = FUNCTION (CONST INSC, UF: STRING): INTEGER; STDCALL;

  Function PreencheZero(S:String; QtdDir:Integer; QtdEsq:Integer):String;
  FUNCTION EDITMONEY(VAR KEY2:Char; TEXTO:TEDIT; ESQ:INTEGER; DIR:INTEGER):BOOLEAN;
  FUNCTION AUTOCOD(VAR QUERY:TADOQuery; FIELD:String; TABLE:STRING):INTEGER;
  FUNCTION CODINUSE(VAR QUERY: TADOQuery; FIELD:STRING; TABLE:STRING; VALUE:STRING):BOOLEAN;
  FUNCTION EDITCOD (VAR KEY2:CHAR) : BOOLEAN;
  FUNCTION COMMABYDOT(TEXTO:STRING):STRING;
  FUNCTION UPPERCASE2(CONST S:STRING): STRING;
  FUNCTION ESPLOWERCASE(CONST S:STRING): STRING;
  FUNCTION GETLISTBOXTEXT(CONST LB:TListBox): STRING;
  FUNCTION GETCHECKLISTBOXTEXT(CONST CLB:TCheckListBox): STRING;
  FUNCTION VALIDACNPJ(CONST CNPJ:STRING):BOOLEAN;
  FUNCTION FORMATACNPJ(CONST CNPJ:STRING): STRING;
  FUNCTION VALIDAIES(CONST IES:STRING; UF:STRING): BOOLEAN;
  FUNCTION VALIDACPF(Const CPF:String):Boolean;

  FUNCTION INVERTESTRING(CONST S:STRING): STRING;
  FUNCTION ALERTMSG(Const sTit:String; sMsg:String; bBtnS:Boolean): Boolean;
//  FUNCTION PopLogin(Const sTit:String): Boolean;
  FUNCTION FormataCampo(sTexto:string; sFormato:string):String;

  var bAlertReturn : Boolean;
      bLoginReturn : Boolean;
implementation

uses Alert_Form, AlertMsg_Form; //Login_Form, LoginMsg_Form;

FUNCTION FormataCampo(sTexto:string; sFormato:string):String;
Var iTexto  : integer;
    iFormato: integer;
begin
  iTexto   := 0;
  iFormato := 0;
  While iTexto <= Length(sTexto) do begin
    if Copy(sFormato,iFormato,1) = 'n' then begin
      Result := Result + Copy(sTexto,iTexto,1);
    end else begin
      Result := Result + Copy(SFormato,iFormato,1);
    end;
    Inc(iTexto);
    Inc(iFormato);
  end;

end;

Function PreencheZero(S:String; QtdDir:Integer; QtdEsq:Integer):String;
Var
  VlDir, VlEsq: String;
begin
  if pos(',',S) = 0 then
    S := S + ',0';

  VlEsq := Copy(S,1,Pos(',',S)-1);
  VlDir := Copy(S,Pos(',',S)+1,Length(S));

  While Length(VlDir) < QtdDir do
    VlDir := VlDir + '0';

  While Length(VlEsq) < QtdEsq do
    VlEsq := '0' + VlEsq;

  Result := VlEsq + ',' + VlDir;
end;




FUNCTION INVERTESTRING(CONST S:STRING): STRING;
VAR
  I: INTEGER;
BEGIN
  FOR I := LENGTH(S) DOWNTO 1 DO BEGIN
    RESULT := RESULT + COPY(S,I,1)
  END;

END;





FUNCTION VALIDAIES(CONST IES:STRING; UF:STRING): BOOLEAN;
VAR
  IRet                      : Integer;
  LibHandle                 : THandle;
  ConsisteInscricaoEstadual : TConsisteInscricaoEstadual;
BEGIN
  TRY
    LibHandle :=  LoadLibrary (PChar (Trim ('DllInscE32.Dll')));
    IF  LibHandle <=  HINSTANCE_ERROR THEN
      RAISE Exception.Create('Dll n?o carregada')
    ;

    @ConsisteInscricaoEstadual  :=  GetProcAddress(LibHandle,'ConsisteInscricaoEstadual');
    IF  @ConsisteInscricaoEstadual  = NIL THEN
      RAISE Exception.Create('Entrypoint Download n?o encontrado na Dll')
    ;

    IRet := ConsisteInscricaoEstadual(IES,UF);
    IF IRET = 0 THEN
      RESULT := TRUE
    ELSE
      RESULT := FALSE
    ;
  FINALLY
    FreeLibrary (LibHandle);
  END;
END;




FUNCTION FORMATACNPJ(CONST CNPJ: STRING): STRING;
BEGIN
  RESULT := ((COPY(CNPJ,1,2))
            + '.'
            + (COPY(CNPJ,3,3))
            + '.'
            + (COPY(CNPJ,6,3))
            + '/'
            + (COPY(CNPJ,9,4))
            + '-'
            + (COPY(CNPJ,13,2)));
END;





FUNCTION VALIDACNPJ(CONST CNPJ: STRING): BOOLEAN;
VAR
  V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, VD1, VD2, VDIGITOS: INTEGER;
BEGIN
    IF LENGTH(CNPJ) <> 14  THEN BEGIN
      RESULT := FALSE;
      EXIT;
    END;

  V1  := (STRTOINT(COPY(CNPJ,1,1))  * 5);
  V2  := (STRTOINT(COPY(CNPJ,2,1))  * 4);
  V3  := (STRTOINT(COPY(CNPJ,3,1))  * 3);
  V4  := (STRTOINT(COPY(CNPJ,4,1))  * 2);
  V5  := (STRTOINT(COPY(CNPJ,5,1))  * 9);
  V6  := (STRTOINT(COPY(CNPJ,6,1))  * 8);
  V7  := (STRTOINT(COPY(CNPJ,7,1))  * 7);
  V8  := (STRTOINT(COPY(CNPJ,8,1))  * 6);
  V9  := (STRTOINT(COPY(CNPJ,9,1))  * 5);
  V10 := (STRTOINT(COPY(CNPJ,10,1)) * 4);
  V11 := (STRTOINT(COPY(CNPJ,11,1)) * 3);
  V12 := (STRTOINT(COPY(CNPJ,12,1)) * 2);
  VDIGITOS := (STRTOINT(COPY(CNPJ,13,2)));


  VD1 := ((V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10 + V11 + V12) MOD 11);
  IF VD1 < 2 THEN
    VD1 := 0
  ELSE
    VD1 := 11 - VD1
  ;

  V1  := (STRTOINT(COPY(CNPJ,1,1))  * 6);
  V2  := (STRTOINT(COPY(CNPJ,2,1))  * 5);
  V3  := (STRTOINT(COPY(CNPJ,3,1))  * 4);
  V4  := (STRTOINT(COPY(CNPJ,4,1))  * 3);
  V5  := (STRTOINT(COPY(CNPJ,5,1))  * 2);
  V6  := (STRTOINT(COPY(CNPJ,6,1))  * 9);
  V7  := (STRTOINT(COPY(CNPJ,7,1))  * 8);
  V8  := (STRTOINT(COPY(CNPJ,8,1))  * 7);
  V9  := (STRTOINT(COPY(CNPJ,9,1))  * 6);
  V10 := (STRTOINT(COPY(CNPJ,10,1)) * 5);
  V11 := (STRTOINT(COPY(CNPJ,11,1)) * 4);
  V12 := (STRTOINT(COPY(CNPJ,12,1)) * 3);
  V13 := VD1 * 2;

  VD2 := ((V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10 + V11 + V12 + V13) MOD 11);
  IF VD2 < 2 THEN
    VD2 := 0
  ELSE
    VD2 := 11 - VD2
  ;

  IF (INTTOSTR(VD1) + INTTOSTR(VD2)) = INTTOSTR(VDIGITOS) THEN
    RESULT := TRUE
  ELSE
    RESULT := FALSE
  ;
END;


FUNCTION VALIDACPF(Const CPF:String):Boolean;
Var
  V1,V2,V3,V4,V5,V6,V7,V8,V9,V10,VD1,VD2,VDIG : INTEGER;
begin
  if Length(CPF) <> 11 then begin
    Result := False;
    exit;
  end;

  V1   := StrToInt(Copy(CPF,01,1)) * 10;
  V2   := StrToInt(Copy(CPF,02,1)) * 09;
  V3   := StrToInt(Copy(CPF,03,1)) * 08;
  V4   := StrToInt(Copy(CPF,04,1)) * 07;
  V5   := StrToInt(Copy(CPF,05,1)) * 06;
  V6   := StrToInt(Copy(CPF,06,1)) * 05;
  V7   := StrToInt(Copy(CPF,07,1)) * 04;
  V8   := StrToInt(Copy(CPF,08,1)) * 03;
  V9   := StrToInt(Copy(CPF,09,1)) * 02;
  VDIG := StrToInt(Copy(CPF,10,2));

  VD1 := (V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9) MOD 11;
  if VD1 < 2 then
    VD1 := 0
  else
    VD1 := 11 - VD1;

  V1   := StrToInt(Copy(CPF,01,1)) * 11;
  V2   := StrToInt(Copy(CPF,02,1)) * 10;
  V3   := StrToInt(Copy(CPF,03,1)) * 09;
  V4   := StrToInt(Copy(CPF,04,1)) * 08;
  V5   := StrToInt(Copy(CPF,05,1)) * 07;
  V6   := StrToInt(Copy(CPF,06,1)) * 06;
  V7   := StrToInt(Copy(CPF,07,1)) * 05;
  V8   := StrToInt(Copy(CPF,08,1)) * 04;
  V9   := StrToInt(Copy(CPF,09,1)) * 03;
  V10  := VD1 * 02;

  VD2 := (V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10) MOD 11;
  if VD2 < 2 then
    VD2 := 0
  else
    VD2 := 11 - VD2;

  if strtoint((IntToStr(VD1) + IntToStr(VD2))) = VDIG then
    Result := True
  else
    Result := False;
end;



FUNCTION GETLISTBOXTEXT(CONST LB : TListBox): STRING;
VAR
  I : INTEGER;
BEGIN
  I := 0;
  WHILE I < LB.Items.Count DO BEGIN
    IF LB.Selected[I] = TRUE THEN BEGIN
      RESULT := LB.ITEMS[I]
    END;
    INC(I);
  END;
END;




FUNCTION GETCHECKLISTBOXTEXT(CONST CLB : TCheckListBox): STRING;
VAR
  I : INTEGER;
BEGIN
  I := 0;
  WHILE I < CLB.Items.Count DO BEGIN
    IF CLB.Selected[I] = TRUE THEN BEGIN
      RESULT := CLB.ITEMS[I]
    END;
    INC(I);
  END;
END;




function ESPLOWERCASE(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then Dec(Ch, 32);
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;





function UpperCase2(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then Dec(Ch, 32);
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    IF CH = '?' THEN CH := '?';
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;




FUNCTION COMMABYDOT(TEXTO:STRING):STRING;
VAR BCOMMA:STRING;
    ACOMMA:STRING;
BEGIN
  IF POS(',',TEXTO) > 0 THEN BEGIN
    BCOMMA := COPY(TEXTO,1,(POS(',',TEXTO)-1));
    ACOMMA := COPY(TEXTO,(POS(',',TEXTO)+1),LENGTH(TEXTO));
    RESULT := BCOMMA + '.' + ACOMMA;
  END ELSE
      RESULT := TEXTO;
  ;
END;




FUNCTION EDITCOD(VAR KEY2:CHAR) : BOOLEAN;
BEGIN
  RESULT := TRUE;

  if (key2 <> '0') and (key2 <> '1') and (key2 <> '2') and (key2 <> '3') and (key2 <> '4') and
     (key2 <> '5') and (key2 <> '6') and (key2 <> '7') and (key2 <> '8') and (key2 <> '9') and
     (key2 <> #08) then begin
  //  windows.Beep(100,50);
      RESULT := FALSE;
  end;
END;




FUNCTION EDITMONEY(VAR KEY2:Char; TEXTO:TEDIT; ESQ:INTEGER; DIR:INTEGER) : Boolean;
BEGIN
  RESULT := TRUE;

  if (key2 <> '0') and (key2 <> '1') and (key2 <> '2') and (key2 <> '3') and (key2 <> '4') and
     (key2 <> '5') and (key2 <> '6') and (key2 <> '7') and (key2 <> '8') and (key2 <> '9') and
     (key2 <> #08) and (key2 <> ',') then begin
  //  windows.Beep(100,50);
      RESULT := FALSE;
  end;

  if ((pos(',',TEXTO.Text) > 0) AND (key2 = ',')) THEN BEGIN
    RESULT := FALSE;
    EXIT;
  END;

  IF ((LENGTH(TEXTO.Text) = 0) AND (KEY2 = ',')) THEN BEGIN
    TEXTO.MaxLength := DIR + 1;
    EXIT;
  END;

  IF POS(',',TEXTO.Text) = 1 THEN
    EXIT
  ;

  if pos(',',TEXTO.Text) = 0 then
      TEXTO.MaxLength := ESQ
  ;

  WHILE ESQ >= 0 DO BEGIN
    If ((TEXTO.GetTextLen = ESQ) AND (key2 = ',')) THEN BEGIN
      TEXTO.MaxLength := TEXTO.GetTextLen + DIR + 1;
      BREAK;
    END;
    DEC(ESQ);
  END;
END;






FUNCTION AUTOCOD(VAR QUERY:TADOQuery; FIELD:String; TABLE:STRING):INTEGER;
VAR
  I: INTEGER;
BEGIN
  QUERY.Close;
  QUERY.SQL.Text := 'SELECT ' + FIELD + ' FROM ' + TABLE + ' ORDER BY ' + FIELD + ' ASC';
  QUERY.Open;

  IF QUERY.RecordCount = 0 THEN BEGIN
    RESULT := 0;
    EXIT;
  END;
                                    +
  I := 0;
  QUERY.First;
  WHILE NOT QUERY.Eof DO BEGIN
    IF (I <> QUERY.FieldByName(FIELD).AsInteger) THEN BEGIN
      RESULT := I;
      EXIT;
    END;
    INC(I);
    QUERY.Next;

    IF QUERY.Eof THEN
      RESULT := I
    ;
  END;
END;





FUNCTION CODINUSE(VAR QUERY: TADOQuery; FIELD:STRING; TABLE:STRING; VALUE:STRING):BOOLEAN;
BEGIN

  QUERY.Close;
  QUERY.SQL.Text := 'SELECT ' + FIELD + ' FROM ' + TABLE + ' WHERE ' + FIELD + ' = ' + INTTOSTR(STRTOINT(VALUE)) + ' AND FL_ATIVO_USU = 1';
  QUERY.Open;

  IF QUERY.RecordCount > 0 THEN
    RESULT := TRUE
  ELSE
    RESULT := FALSE
  ;
END;


FUNCTION ALERTMSG(Const sTit:String; sMsg:String; bBtnS:Boolean): Boolean;
begin
  if frmAlert = Nil then
    frmAlert := TfrmAlert.Create(Nil);

  frmAlert.sTitulo := sTit;
  frmAlert.sMsg    := sMsg;
  frmAlert.bBtnS   := bBtnS;

  frmAlert.ShowModal;

  Result := bAlertReturn;

  frmAlert.Close;
end;

{
FUNCTION PopLogin(Const sTit:String): Boolean;
begin
  if frmLogin = Nil then
    frmLogin := TfrmLogin.Create(Nil);

  frmLogin.sTitulo := sTit;
  frmLogin.ShowModal;

  Result := bLoginReturn;
  frmLogin.Close;
end;
}





end.
