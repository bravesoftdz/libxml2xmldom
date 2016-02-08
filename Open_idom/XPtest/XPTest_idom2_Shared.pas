unit XPTest_idom2_Shared;

interface

uses
  IniFiles,
  domSetup,
  idom2,
  idom2_ext,
  sysutils,
  TestFrameworkIfaces,
  TestFramework,
  Classes,
  Dialogs;

const
  CRLF    = #13#10;
  xmlns   = 'http://www.w3.org/2000/xmlns/';
  xmldecl = '<?xml version="1.0" encoding="iso-8859-1"?>';
  xmlstr  = xmldecl + '<test />';
  xmlstr1 = xmldecl + '<test xmlns=''http://ns.4ct.de''/>';
  xmlstr2 = xmldecl +
            '<!DOCTYPE root [' +
            '<!ELEMENT root (test*)>' +
            '<!ELEMENT test (#PCDATA)>' +
            '<!ATTLIST test name CDATA #IMPLIED>' +
            '<!ENTITY ct "4 commerce technologies">' +
            '<!NOTATION type2 SYSTEM "program2">' +
            '<!ENTITY FOO2 SYSTEM "file.type2" NDATA type2>' +
            ']>' +
            '<root />';
  xmlstr3 = xmldecl +
            '<xObject'+
            ' id="xcl.customers.list"'+
            ' executor="sql"'+
            ' xmlns:xob="http://xmlns.4commerce.de/xob"'+
            ' auth="xcl.customers.list"'+
            ' connection="ib.kis"'+
            '>' +
            '  <result />' +
            '</xObject>';
  xmlstr4 = xmldecl +
            '<!DOCTYPE root [' +
            '<!ELEMENT root (#PCDATA)>' +
            '<!ATTLIST root attr-implied  CDATA #IMPLIED>' +
            '<!ATTLIST root attr-default  CDATA "default-value">' +
            '<!ATTLIST root attr-required CDATA #REQUIRED>' +
            '<!ATTLIST root attr-fixed    CDATA #FIXED "fixed-value">' +
            ']>' +
            '<root attr-required="required-value" />';

  // DTDs are not intented to work with namespaces, but msxml and libxml2
  // can handles the following kind of declaration

  xmlstr5 = xmldecl +
            '<!DOCTYPE root [' +
            '<!ELEMENT root (#PCDATA)>' +
            '<!ATTLIST root xmlns:abc         CDATA #FIXED "http://ABC">'+
            '<!ATTLIST root abc:attr-implied  CDATA #IMPLIED>' +
            '<!ATTLIST root abc:attr-default  CDATA "default-value">' +
            '<!ATTLIST root abc:attr-fixed    CDATA #FIXED "fixed-value">' +
            ']>' +
            '<root />';
  xslstr  = xmldecl +
            '<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"' +
            '                version="1.0">' +
            '  <xsl:output method="html"' +
            '              version="4.0"' +
            //'              omit-xml-declaration="yes"'+
            '              doctype-public="-//W3C//DTD HTML 4.0 Transitional//EN"' +
            '              doctype-system="http://www.w3.org/TR/REC-html40/loose.dtd"' +
            '              encoding="ISO-8859-1" />' + '  <xsl:template match="/*">' +
            '    <html>' +
            '      <head>' +
            '        <title><xsl:value-of select="name()" /></title>' +
            '      </head>' +
            '      <body>' +
            '        <h1><xsl:value-of select="name()" /></h1>' +
            '      </body>' +
            '    </html>' +
            '  </xsl:template>' +
            '</xsl:stylesheet>';
  xslstr2 = xmldecl +
            '<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"' +
            '                version="1.0">' +
            '  <xsl:output method="xml"' +
            '              doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"' +
            '              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"' +
            '              encoding="iso-8859-1" />' +
            '  <xsl:template match="/*">' +
            '    <html>' +
            '      <head>' +
            '        <title><xsl:value-of select="name()" /></title>' +
            '      </head>' +
            '      <body>' +
            '        <h1><xsl:value-of select="name()" /></h1>' +
            '      </body>' +
            '    </html>' +
            '  </xsl:template>' +
            '</xsl:stylesheet>';
  xslstr1 = xmldecl +
            '<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"' +
            '                version="1.0">' +
            '  <xsl:output method="text"' +
            //'              omit-xml-declaration="yes"'+
            '              encoding="ISO-8859-1" />' +
            '  <xsl:template match="/*">' +
            '    <xsl:value-of select="name()" />' +
            '  </xsl:template>' +
            '</xsl:stylesheet>';
  outstr  = '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">' +
            '<html>' +
            '<head>' +
            '<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">' +
            '<title>test</title>' +
            '</head>' +
            '<body>' +
            '<h1>test</h1>' +
            '</body>' +
            '</html>';
  outstr1 = xmldecl +
            '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' +
            '<html xmlns="http://www.w3.org/1999/xhtml">' +
            '<head>' +
            '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />' +
            '<title>test</title>' +
            '</head>' +
            '<body>' +
            '<h1>test</h1>' +
            '</body>' +
            '</html>';

type
  TMemoryTestCase = class(TTestCase)
  private
    mem: cardinal;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  end;

type

  { TMyTestCase }

  TMyTestCase = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
    constructor CreateWithName(const Name: String);
  end;

function getCurMemory: cardinal;
function getDataPath: string;
function domvendor: string;
function myIsSameNode(node1, node2: IDomNode): boolean;
function Unify(xml: widestring; removeEncoding: boolean = True): widestring;
function GetHeader(xml: string): string;
function StrCompare(str1, str2: WideString): integer;
function DupeString(const AText: string; ACount: Integer): string;
function IncludeTrailingPathDelimiter(const S: string): string;
function getUnicodeStr(mode: integer = 0): WideString;
function GetDoccount(impl:IDomImplementation):integer;
procedure debugDom(doc: IDOMDocument;bUnify: boolean=false);
procedure debugAttributes(attributes: IDOMNamedNodeMap; entities: boolean = False);
function PrettyPrint(text: WideString): WideString;
function getEnabledTests(suite: ITestSuite;domVendor,className:string): TStrings;

var
  datapath: string = '';

implementation

const
  PathDelim  = {$IFNDEF LINUX} '\'; {$ELSE} '/'; {$ENDIF}

function getEnabledTests(suite: ITestSuite;domVendor,className:string): TStrings;
// returns a stringlist with the names of the enabled tests
// for a given domVendor and className
// the domvendor is the string, displayed in the testsuite, and not
// the string, returned by the function domvendor
// the strings are case sensitive

var
  i,j,k,l: integer;
  test,test1,test2,test3: ITestSuite;
  lastTest, lastTest1, lastTest2, lastTest3: ITest;
begin
  result := TStringList.Create;
  {$IFDEF FPC}
  suite.Reset;
  lastTest := suite.CurrentTest;
  test := suite.FindNextEnabledProc as ITestSuite;
  while test <> lastTest do
  begin
    test.Reset;
    lastTest1 := test.CurrentTest;
    test1 := test.FindNextEnabledProc as ITestSuite;
    while test1 <> lastTest1 do
      if test1.GetName=domVendor then
      begin
        test1.Reset;
        lastTest2 := test.CurrentTest;
        test2 := test.FindNextEnabledProc as ITestSuite;
        while test2 <> lastTest2 do
        if // test2.EnableIgnores and
          (test2.GetName = className) then
        begin
          test2.Reset;
          lastTest3 := test.CurrentTest;
          test3 := test.FindNextEnabledProc as ITestSuite;
          while test3 <> lastTest3 do
          begin
            // if test3.EnableIgnores then
            result.Add(test3.GetName);
          end;
        end;
      end;
    end;
  {$ELSE}
  for i := 0 to suite.tests.Count-1 do begin
    test := suite.Tests[i] as ITest;
    for j:=0 to test.Tests.Count-1 do begin
      test1:=test.tests[j] as ITest;
      if test1.Name=domVendor then begin
        for k:=0 to test1.tests.count-1 do begin
          test2:=test1.tests[k] as ITest;
          if test2.Enabled and (test2.Name = className) then begin
            for l:=0 to test2.tests.count-1 do begin
              test3:=test2.tests[l] as ITest;
              if test3.Enabled then result.Add(test3.Name);
            end;
          end;
        end;
      end;
    end;
  end;
  {$ENDIF}
end;

function DupeString(const AText: string; ACount: Integer): string;
var
  P: PChar;
  C: Integer;
begin
  C := Length(AText);
  SetLength(Result, C * ACount);
  P := Pointer(Result);
  if P = nil then Exit;
  while ACount > 0 do
  begin
    Move(Pointer(AText)^, P^, C);
    Inc(P, C);
    Dec(ACount);
  end;
end;

function PrettyPrint(text: WideString): WideString;
// text: a wellformed xml document
// adds spaces and crlfs to make the document better readable for humans
const
  indentstr = '  ';
  exclude = [WideChar(#9),WideChar(#13),WideChar(#10)]; // exclude formating characters : tab, control, linefeed
var
  i,indentlevel: integer;
  temp: WideString;
begin
  // this routine assumes that text is a wellformed xml structure
  // get rid off formating
  temp := '';
  for i := 1 to Length(text) do begin
    if not(text[i] in exclude) then begin
     temp := temp + text[i]; // copy any character that is not in the exclude list
    end;
  end;
  text := temp;
  i := 1; // strings start with index 1
  indentlevel := 0; // no indention at start
  while i <= Length(text) do begin // go through the text
    if text[i] = '<' then begin // tag-start
      // we won't find '<' at the end of a wellformed xml structure
      // so we can look up the next character without getting an index error
      if text[i+1] <> '!' then begin
        if text[i+1] <> '/' then begin // start-tag
          if text[i-1] <> '>' then begin // start-tag with leading text
            result := result + CRLF;
          end;
          result := result + DupeString(indentstr,indentlevel) + '<';
          if text[i+1] <> '?' then inc(indentlevel);
        end else begin // end-tag
          dec(indentlevel);
          // any other character than '<' won't be at the start of a wellformed xml
          // structure so we can look up the previous character without getting an
          // index error
          if text[i-1] <> '>' then begin // with leading text
            result := result + '</';
          end else begin // with leading tag
            result := result + DupeString(indentstr,indentlevel) + '</';
          end;
          inc(i); // jump over the next character
        end;
      end else begin // some section starts
        // the CDATA-section may contain unescaped characters
        // we leave the context of the xml structure until
        // we've found the end of the CDATA-section
        // we'll find it before end of file because of wellformedness
        if Copy(text,i,Length('<![CDATA[')) = '<![CDATA[' then begin // CDATA-section
          inc(i,9);
          result := result + DupeString(indentstr,indentlevel) + '<![CDATA[';
          while Copy(text,i,Length(']]>')) <> ']]>' do begin
            result := result + text[i]; // simply append the content of the CDATA section
            inc(i); // process the next character
          end;
          result := result + ']]>' + CRLF;
          inc(i,2); // jump over the next 2 characters - we already appended them
        end;
      end;
    end else begin // anything else but a tag-start
      // we won't find '/' at the end of a wellformed xml structure
      // so we can look up the next character without getting an index error
      if (text[i] = '/') and (text[i+1] = '>') then begin // short-tag
        result := result + '/>' + CRLF;
        inc(i); // jump over the next character
        dec(indentlevel);
      end else begin
        if text[i] = '>' then begin // tag-end
          // '>' is the last character of a wellformed xml structure
          // in this case we should not look up the next character
          if i < Length(text) then begin // tag-end in the middle
            if text[i+1] = '<' then begin // tag-end with following tag
              result := result + '>' + CRLF;
            end else begin // tag-end with following text
              result := result + '>';
            end;
          end else begin // tag end at end of text
            // the two trailing linefeeds make it pretty
            // if appending two PrettyPrint results
            result := result + CRLF + CRLF;
          end;
        end else begin // any other character
          result := result + text[i]; // simply append it
        end;
      end;
    end;
    inc(i); // process the next character
  end;
end;

procedure debugDom(doc: IDOMDocument;bUnify: boolean=false);
begin
  if bUnify
    then showMessage(prettyPrint(unify((doc as IDOMPersist).xml)))
    else showMessage(prettyPrint((doc as IDOMPersist).xml));
end;

procedure debugAttributes(attributes: IDOMNamedNodeMap; entities: boolean = False);
var
  i: integer;
  text: string;
  sname,svalue: string;
begin
  text := 'attributes';
  for i := 0 to attributes.length-1 do begin
    sname  := attributes[i].nodeName;
    if attributes[i].nodeType = ENTITY_NODE
      then svalue := 'none'
      else svalue := attributes[i].nodeValue;
    text := Format('%s%sname="%s" value="%s"',[text,CRLF,sname,svalue]);
  end;
  showMessage(text);
end;

// load actual memory state from machine
function getCurMemory: cardinal;
begin
  {$ifdef linux}
  result := mallinfo.uordblks;
  {$else}
  result := GetHeapStatus.TotalAllocated;
  {$endif}
end;

function getUnicodeStr(mode: integer = 0): WideString;
  // this function returns an unicode string
var
  i: integer;
begin
  result := '';
  case mode of
    0: begin
         // return an unicode string with all defined greek and coptic characters
         for i := $0370 to $03FF do begin
           case i of
             $0370..$0373,$0376..$0379,$037B..$037D,$037F..$0383,
             $038B,$038D,$03A2,$03CF,$03D8,$03D9,$03F6..$03FF: // exclude undefined
           else
             result := result + WideChar(i);
           end;
         end;
       end;
    1: begin
         // return an unicode string that is save for tag names
         result := result + WideChar($0391)+WideChar($0392)+WideChar($0395);
       end;
  end;
end;

function IsPathDelimiter(const S: string; Index: Integer): Boolean;
begin
  Result := (Index > 0) and (Index <= Length(S)) and (S[Index] = PathDelim)
    and (ByteType(S, Index) = mbSingleByte);
end;

function IncludeTrailingPathDelimiter(const S: string): string;
begin
  Result := S;
  if not IsPathDelimiter(Result, Length(Result)) then
    Result := Result + PathDelim;
end;

function getDataPath: string;
  // this function returns the path to the sample files
const
  cDefault = '..' + PathDelim + 'data';
var
  ini: TIniFile;
begin
  try
    // ignore, that we connot load, maybe its readonly by cvs checkout
    ini := TIniFile.Create('.' + PathDelim + 'XPTestSuite_idom2.ini');
    result := Ini.ReadString('TestDocuments', 'DataPath', cDefault);
    ini.Free;
  except
    result := cDefault;
  end;
  result := IncludeTrailingPathDelimiter(result);
end;

function domvendor: string;
begin
  Result := domSetup.getCurrentDomSetup.getVendorID;
end;

function Unify(xml: widestring; removeEncoding: boolean = True): widestring;
// this procedure unifies the result of the method xml of IDomPersist
// todo: unify doesn't handle unicode correctly!
var
  len : integer;
begin
  xml := StringReplace(xml, #13, '', [rfReplaceAll]);
  xml := StringReplace(xml, #10, '', [rfReplaceAll]);
  xml := StringReplace(xml, #9, '', [rfReplaceAll]);
  if removeEncoding then
    if pos(WideString('<?xml'),xml) > 0 then begin
      len := Pos(WideString('>'),xml) + 1;
      xml := Copy(xml,len,length(xml)-len+1);
    end;
  result := xml;
end;

function LeftStr(const AText: string; const ACount: Integer): string;
begin
  Result := Copy(AText, 1, ACount);
end;

function GetHeader(xml: string): string;
begin
  result:=leftstr(xml,pos('>',xml));
end;

function StrCompare(str1, str2: WideString): integer;
  // compares two strings
  // if they are equal, zero is the return value
  // if they are unqual, it returns the position,
  // where there is a difference
var
  i: integer;
  len, len1, len2: integer;
begin
  Result := 0;
  if str1 = str2 then exit;
  len1 := length(str1);
  len2 := length(str2);
  len := len1;
  if len2 < len1 then len := len2;
  for i := 0 to len do begin
    if leftstr(str1, i) <> leftstr(str2, i) then begin
      Result := i;
      exit
    end;
  end;
  if len < len1 then Result := len + 1;
  if len < len2 then Result := len + 1;
end;

function myIsSameNode(node1, node2: IDomNode): boolean;
  // compare if two nodes are the same (not equal)
var
  domcompare: IDomNodeCompare;
begin
  // node1 might be nil
  // querying an interface of nil results in an acess violation
  if (node1 = nil) or (node2 = nil) then begin
    if node1 = node2 then result := True
                     else result := False;
    exit;
  end;
  node1.QueryInterface(IDomNodeCompare,domcompare);
  if (domcompare <> nil)
    then Result := (node1 as IDomNodeCompare).IsSameNode(node2)
    else Result := ((node1 as IUnknown) = (node2 as IUnknown));
end;

{ TMemoryTestCase }

procedure TMemoryTestCase.SetUp;
begin
  inherited;
  mem := getCurMemory;
end;

procedure TMemoryTestCase.TearDown;
var
  memdelta: cardinal;
begin
  inherited;
  memdelta := GetCurMemory - mem;
  check(memdelta < 2500, Format('memory leak with %d bytes', [memdelta]));
end;

function GetDoccount(impl:IDomImplementation):integer;
var
  domdebug: IDomDebug;
begin
  result:=0;
  if (not Assigned(impl)) then exit;
  impl.queryInterface(IDomDebug,domdebug);
  if domdebug<>nil
    then result:=domdebug.doccount;
end;


{ TMyTestCase }

procedure TMyTestCase.SetUp;
begin

end;

procedure TMyTestCase.TearDown;
begin

end;

constructor TMyTestCase.CreateWithName(const Name: String);
begin
  inherited Create(Name);
end;

end.
