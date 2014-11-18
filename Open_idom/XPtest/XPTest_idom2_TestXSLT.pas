unit XPTest_idom2_TestXSLT;

interface

uses
  fpcunit,
  idom2,
  idom2_ext,
  SysUtils,
  domSetup,
  XPTest_idom2_Shared,
{$ifndef linux}
  ActiveX,
{$endif}
  Classes;

type
  TTestXSLT = class(TMyTestCase)
  private
    impl: IDomImplementation;
    xml: IDomDocument;
    xsl: IDomDocument;
    xnode: IDomNode;
    snode: IDomNode;
  protected
    procedure ClearUp;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    (*
     * XSLT capabilities
     *)
    procedure transformNode2PlainText_WideString;
    procedure transformNode2PlainText_DomDocument;
    procedure transformNode2Html4_WideString;
    //procedure transformNode2Html4_DomDocument;
    procedure transformNode2XHTML_DomDocument;
    procedure transformNode2XHTML_WideString;
    procedure transformNodeVersion10;
    procedure transformNodeSimplifiedSyntax;
    procedure transformNodeNonTerminatingLoop;
    (*
     * IDomNodeEx capabilities
     *)
    procedure setText;
    procedure getText;
    procedure getXml;
    procedure getXmlWithUmlauts;
    procedure loadXmlUnicode;
    (*
     * IDomNodeListEx capabilities
     *)
    procedure getXml_NodeList;
  end;

implementation


{ TTestXSLT }

procedure TTestXSLT.getText;
const
  n = 10;
var
  node:     IDomNode;
  i:        integer;
  textnode: IDomText;
  tmp:      string;
begin
  node := xml.documentElement;
  for i := 0 to n - 1 do begin
    tmp := tmp + 'test' + IntToStr(i);
    textnode := xml.createTextNode('test' + IntToStr(i));
    node.appendChild(textnode);
  end;
  check((node as IDomNodeExt).Text = tmp, 'wrong content');
end;

procedure TTestXSLT.setText;
var
  node: IDomNode;
  i:    integer;
  tmp:  string;
begin
  node := xml.createElement('test');
  xml.documentElement.appendChild(node);
  node := xml.documentElement;
  (node as IDomNodeExt).Text := 'test';
  check((node as IDomNodeSelect).selectNode('test') = nil, '<test /> not removed');
  for i := 0 to node.childNodes.length - 1 do begin
    if node.childNodes[i].nodeType = TEXT_NODE then begin
      tmp := tmp + node.childNodes[i].nodeValue;
    end else begin
      fail('wrong nodeType found - there should be a text node');
    end;
  end;
  check(tmp = 'test', 'wrong textual content');
end;

procedure TTestXSLT.ClearUp;
begin
  snode := nil;
  xnode := nil;
  xsl := nil;
  xml := nil;
  impl := nil;
end;

procedure TTestXSLT.SetUp;
begin
  ClearUp; // reset all

  impl := DomSetup.getCurrentDomSetup.getDocumentBuilder.domImplementation;
  xml := impl.createDocument('', '', nil);
  (xml as IDomPersist).loadxml(xmlstr);
  xsl := impl.createDocument('', '', nil);
end;

procedure TTestXSLT.TearDown;
begin
  ClearUp; // reset all
end;

procedure TTestXSLT.transformNode2Html4_WideString;
var
  Text: widestring;
  ok:   boolean;
begin
  // apply a stylesheet that produces html-output
  ok := (xsl as IDomPersist).loadxml(xslstr);
  check(ok, 'stylesheet no valid xml');
  xnode := xml as IDomNode;
  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeExt).transformNode(snode, Text);
  Text := Unify(Text);
  CheckEquals(outstr, Text, 'wrong content');
//  check(Text = outstr, 'wrong content');
end;

// libxmldom wrapper currently does not support html documents
// use xhtml instead
{
procedure TTestXSLT.transformNode2Html4_DomDocument;
var
  doc:  IDomDocument;
  Text: string;
begin
  // apply a stylesheet that produces html-output
  (xsl as IDomPersist).loadxml(xslstr);
  xnode := xml as IDomNode;
  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeEx).transformNode(snode, doc);
  Text := Unify((doc as IDomPersist).xml);
  check(Text = outstr, 'wrong content');
end;
}

procedure TTestXSLT.transformNodeVersion10;
var
  Text: widestring;
begin
  // any XSLT 1.0 processor must be able to process the following stylesheet
  // without error, although the stylesheet includes elements from the XSLT
  // namespace that are not defined in this specification

  Text :=
    '<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">' +
    '  <xsl:template match="/">' +
    '    <xsl:choose>' +
    '      <xsl:when test="system-property(''xsl:version'') >= 1.1">' +
    '        <xsl:exciting-new-1.1-feature/>' +
    '      </xsl:when>' +
    '      <xsl:otherwise>' +
    '        <html>' +
    '        <head>' +
    '          <title>XSLT 1.1 required</title>' +
    '        </head>' +
    '        <body>' +
    '          <p>Sorry, this stylesheet requires XSLT 1.1.</p>' +
    '        </body>' +
    '        </html>' +
    '      </xsl:otherwise>' +
    '    </xsl:choose>' +
    '  </xsl:template>' +
    '</xsl:stylesheet>';

  (xsl as IDomPersist).loadxml(Text);
  xnode := xml as IDomNode;
  snode := xsl.documentElement as IDomNode;
  try
    (xnode as IDomNodeExt).transformNode(snode, Text);
  except
    fail('transformation raises exception');
  end;
end;

procedure TTestXSLT.transformNode2PlainText_WideString;
var
  Text: widestring;
begin
  // apply a stylesheet that produces text-output

  (xsl as IDomPersist).loadxml(xslstr1);
  xnode := xml as IDomNode;
  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeExt).transformNode(snode, Text);
  check(Text = 'test', 'wrong content - expected: "test" found: "' + Text + '"');
end;

procedure TTestXSLT.transformNode2PlainText_DomDocument;
var
  doc: IDomDocument;
begin
  // apply a stylesheet that produces text-output
  (xsl as IDomPersist).loadxml(xslstr1);
  xnode := xml as IDomNode;
  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeExt).transformNode(snode, doc);
  check(doc.documentElement = nil, 'documentElement<>nil')
end;

procedure TTestXSLT.transformNodeSimplifiedSyntax;
var
  Text, result1, result2: widestring;
begin
  // A simplified syntax is allowed for stylesheets that consist of only a
  // single template for the root node. The stylesheet may consist of just a
  // literal result element. Such a stylesheet is equivalent to a stylesheet
  // with an xsl:stylesheet element containing a template rule containing the
  // literal result element; the template rule has a match pattern of /.

  Text := xmldecl + '<data><expense-report><total>120.000 Euro</total></expense-report></data>';
  (xml as IDomPersist).loadxml(Text);
  xnode := xml as IDomNode;
  Text :=
    '<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/TR/xhtml1/strict">' +
    '  <head>' +
    '    <title>Expense Report Summary</title>' +
    '  </head>' +
    '  <body>' +
    '    <p>Total Amount: <xsl:value-of select="expense-report/total"/></p>' +
    '  </body>' +
    '</html>';
  (xsl as IDomPersist).loadxml(Text);
  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeExt).transformNode(snode, result1);

  Text :=
    '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/TR/xhtml1/strict">' +
    '<xsl:template match="/">' +
    '<html>' +
    '  <head>' +
    '    <title>Expense Report Summary</title>' +
    '  </head>' +
    '  <body>' +
    '    <p>Total Amount: <xsl:value-of select="expense-report/total"/></p>' +
    '  </body>' +
    '</html>' +
    '</xsl:template>' +
    '</xsl:stylesheet>';

  (xsl as IDomPersist).loadxml(Text);

  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeExt).transformNode(snode, result2);
  check(result1 = result2, 'different output');
end;

procedure TTestXSLT.transformNodeNonTerminatingLoop;
// this test is handled by libxml correctly,
// but causes huge memory leaks, therefore it is disabled
// by default
{
var
  Text, result1: widestring;
}
begin
  check(true);
  // When xsl:apply-templates is used to process elements that are not
  // descendants of the current node, the possibility arises of non-terminating
  // loops.

{
  xnode := xml as IDomNode;
  Text :=
    '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/TR/xhtml1/strict">' +
    '<xsl:template match="/">' +
    '  <xsl:apply-templates select="."/>' +
    '</xsl:template>' +
    '</xsl:stylesheet>';
  (xsl as IDomPersist).loadxml(Text);
  snode := xsl.documentElement as IDomNode;
  try
    (xnode as IDomNodeExt).transformNode(snode, result1);
    fail('There should have been an EDomError');
  except
  end;
}
end;

procedure TTestXSLT.getXml;
var
  Text: widestring;
  ok:   boolean;
begin
  Text := xmldecl + '<root><data><test name="test1" success="yes"/></data></root>';
  ok := (xml as IDomPersist).loadxml(Text);
  check(ok, 'text no valid xml');
  Text := Unify((xml.documentElement.firstChild as IDomNodeExt).xml);
  check(Text = '<data><test name="test1" success="yes"/></data>', 'wrong content');
end;

procedure TTestXSLT.transformNode2XHTML_DomDocument;
var
  doc:  IDomDocument;
  Text: string;
  ok:   boolean;
begin
  ok := (xsl as IDomPersist).loadxml(xslstr2);
  check(ok, 'stylesheet no valid xml');
  xnode := xml as IDomNode;
  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeExt).transformNode(snode, doc);
  Text := (doc as IDomPersist).xml;
  Text := Unify(Text,False);
  check(Text = outstr1, 'wrong content');
end;

procedure TTestXSLT.transformNode2XHTML_WideString;
var
  Text: widestring;
  ok:   boolean;
begin
  ok := (xsl as IDomPersist).loadxml(xslstr2);
  check(ok, 'stylesheet is not a valid xml document');
  xnode := xml as IDomNode;
  snode := xsl.documentElement as IDomNode;
  (xnode as IDomNodeExt).transformNode(snode, Text);
  Text := Unify(Text,False);
  check(Text = outstr1, 'wrong content');
end;

procedure TTestXSLT.getXmlWithUmlauts;
var
  teststr,str1,str2: widestring;
begin
  // test how loadxml behaves with 'umlauts'
  str1:='<root><text>äöüß</text><text>ÄÖÜ</text></root>';
  teststr := xmldecl+str1;
  (xml as IDOMPersist).loadxml(teststr);
  str2:=(xml.documentElement as IDomNodeExt).xml;
  check(str1=str2,'wrong output');
end;

procedure TTestXSLT.loadXmlUnicode;
var
  teststr,rootstr,parsestr,resultstr: widestring;
begin
  teststr := getunicodestr(1);
  rootstr := '<root><text>'+teststr+'</text><text>ÄÖÜ</text></root>';
  parsestr := '<?xml version="1.0" encoding="utf8"?>'+ rootstr;

  check((xml as IDOMPersist).loadxml(parsestr),'parse error');
  check(xml.documentElement.hasChildNodes, 'has no childNodes');
  check(xml.documentElement.childNodes.length = 2, 'wrong length');
  check(xml.documentElement.firstChild.firstChild.nodeType = TEXT_NODE, 'wrong nodeType');
  check(xml.documentElement.lastChild.firstChild.nodeType = TEXT_NODE, 'wrong nodeType');
  check(xml.documentElement.firstChild.firstChild.nodeValue = teststr, 'wrong nodeValue');
  check(xml.documentElement.lastChild.firstChild.nodeValue = 'ÄÖÜ', 'wrong nodeValue');
  resultstr:=(xml.documentElement as IDomNodeExt).xml;
  check((resultstr = rootstr), 'xml output is different from parsed text ... "'+unify((xml.documentElement as IDomNodeExt).xml)+'"');
end;

procedure TTestXSLT.getXml_NodeList;
const
  xmlstr1 = xmldecl+
            '<root>'+
            '<child1/>'+
            '<child2 attr1=""/>'+
            '<child3 attr2="value-of-attr2"/>'+
            '<child4><subchild1/></child4>'+
            '<child5>some example text</child5>'+
            '</root>';
var
  xmlstr2: string;
  nodelist: IDOMNodeList;
  nlext: IDOMNodeListExt;
begin
  check((xml as IDOMPersist).loadxml(xmlstr1), 'parse error');
  nodelist := (xml.documentElement as IDOMNodeSelect).selectNodes('./*');
  if nodelist.QueryInterface(IDOMNodeListExt,nlext) = 0 then begin
    // get rid of the formating
    xmlstr2 := StringReplace(nlext.xml,#10,'',[rfReplaceAll]);
    // add the header
    xmlstr2 := xmldecl+'<root>'+xmlstr2+'</root>';
    check(xmlstr1 = xmlstr2, 'different content');
  end else begin
    fail('Interface IDOMNodeListExt not supported');
  end;
end;

initialization
  datapath := getDataPath;
  {$ifndef linux}
  CoInitialize(nil);
  {$endif}
  {$ifdef linux}
  ;
  {$endif}
end.
