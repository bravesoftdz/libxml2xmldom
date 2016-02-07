unit XPTest_idom2_TestDomExceptions;

{$MODE Delphi}

interface

uses
  {TestFrameWork,}
  idom2,
  idom2_ext,
  domSetup,
  SysUtils,
  XPTest_idom2_Shared,
{$ifndef linux}
  ActiveX;
{$endif}


type
  TTestDomExceptions = class(TMyTestCase)
  private
    impl: IDomImplementation;
    doc: IDomDocument;
    doc1: IDomDocument;
    elem: IDomElement;
    prefix: string;
    Name: string;
    nsuri: string;
    Data: string;
    attr: IDomAttr;
    node: IDomNode;
    select: IDomNodeSelect;
    nodelist: IDomNodeList;
    nnmap: IDOMNamedNodeMap;
    pci: IDomProcessingInstruction;
    entref: IDomEntityReference;
    ent: IDOMEntity;
    nota: IDOMNotation;
    cdata: IDomCharacterData;
    text: IDOMText;
    noex: boolean;
    function getFqname: string;
  protected
    procedure ClearUp;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // the first part of the name identifies the type of exception to be raised
    // the second part of the name is the name of the method
    (* hierarchy *)
    procedure hierarchy_AppendAttribute;
    procedure hierarchy_appendChild1;
    procedure hierarchy_appendChild2;
    procedure hierarchy_appendChild3;
    procedure hierarchy_InsertAnchestor;
    procedure hierarchy_insertBefore1;
    procedure hierarchy_insertBefore2;
    procedure hierarchy_insertBefore3;
    procedure hierarchy_insertBefore4;
    procedure hierarchy_removeChild2;
    procedure hierarchy_replaceChild1;
    procedure hierarchy_setNamedItem3;
    procedure hierarchy_setNamedItem4;
    procedure hierarchy_setNamedItemNS3;
    procedure hierarchy_setNamedItemNS4;
    (* index *)
    procedure index_deleteData1;
    procedure index_deleteData2;
    procedure index_deleteData3;
    procedure index_insertData1;
    procedure index_insertData2;
    procedure index_replaceData1;
    procedure index_replaceData2;
    procedure index_replaceData3;
    procedure index_substringData1;
    procedure index_substringData2;
    procedure index_substringData3;
    procedure index_splitText1;
    procedure index_splitText2;
    (* inuse *)
    procedure inuse_setAttributeNode2;
    procedure inuse_setAttributeNodeNS2;
    procedure inuse_setNamedItem2;
    procedure inuse_setNamedItemNS2;
    (* invalidchar *)
    procedure invalidchar_createAttribute1;
    procedure invalidchar_createAttributeNS1;
    procedure invalidchar_createDocument;
    procedure invalidchar_createElement1;
    procedure invalidchar_createElementNS1;
    procedure invalidchar_createEntityReference1;
    procedure invalidchar_createProcessingInstruction1;
    procedure invalidchar_setAttribute1;
    procedure invalidchar_setAttributeNS1;
    (* namespace *)
    procedure namespace_already_bound_prefix_createElementNS;
    procedure namespace_already_bound_prefix_setAttributeNodeNS;
    procedure namespace_already_bound_prefix_setAttributeNS;
    procedure namespace_createAttributeNS2;
    procedure namespace_createAttributeNS3;
    procedure namespace_createAttributeNS4;
    procedure namespace_createAttributeNS5;
    procedure namespace_createAttributeNS6;
    procedure namespace_createDocument1;
    procedure namespace_createDocument2;
    procedure namespace_createDocument3;
    procedure namespace_createElementNS2;
    procedure namespace_createElementNS3;
    procedure namespace_createElementNS4;
    procedure namespace_setAttributeNS2;
    procedure namespace_setAttributeNS3;
    procedure namespace_setAttributeNS4;
    procedure namespace_setAttributeNS5;
    procedure namespace_setAttributeNS6;
    (* notfound *)
    procedure notfound_insertBefore6;
    procedure notfound_removeAttributeNode1;
    procedure notfound_removeChild1;
    procedure notfound_removeNamedItem1;
    procedure notfound_removeNamedItemNS2;
    procedure notfound_removeNamedItemNS3;
    procedure notfound_replaceChild3;
    (* readonly *)
    procedure readonly_nodeValue;
    procedure readonly_removeAttribute;
    procedure readonly_removeAttributeNode;
    procedure readonly_removeAttributeNS;
    procedure readonly_removeNamedItem_attr;
    procedure readonly_removeNamedItem_entity;
    procedure readonly_removeNamedItem_notation;
    procedure readonly_removeNamedItemNs_attr;
    procedure readonly_setAttribute;
    procedure readonly_setAttributeNode;
    procedure readonly_setAttributeNodeNS;
    procedure readonly_setAttributeNS;
    procedure readonly_setAttributeNS1;
    procedure readonly_setNamedItem_attr;
    procedure readonly_setNamedItemNs_attr;
    procedure readonly_value;
    (* unknown *)
    procedure unknown_AppendNilNode;
    procedure unknown_InsertNilNode;
    procedure unknown_selectNodes3;
    (* wrongdoc *)
    procedure wrongdoc_appendChild4;
    procedure wrongdoc_insertBefore5;
    procedure wrongdoc_replaceChild2;
    procedure wrongdoc_setAttributeNode1;
    procedure wrongdoc_setAttributeNodeNS1;
    procedure wrongdoc_setNamedItem1;
    procedure wrongdoc_setNamedItemNS1;
    (* others *)
    property fqname: string read getFqname;
  end;

implementation

uses
  {$IFDEF VER300} System.Win.ComObj; {$ELSE} ComObj; {$ENDIF}

function getCodeStr(code: integer): string;
begin
  result := 'error';
  case code of
    INDEX_SIZE_ERR                : Result := 'INDEX_SIZE_ERR';
    DOMSTRING_SIZE_ERR            : Result := 'DOMSTRING_SIZE_ERR';
    HIERARCHY_REQUEST_ERR         : Result := 'HIERARCHY_REQUEST_ERR';
    WRONG_DOCUMENT_ERR            : Result := 'WRONG_DOCUMENT_ERR';
    INVALID_CHARACTER_ERR         : Result := 'INVALID_CHARACTER_ERR';
    NO_DATA_ALLOWED_ERR           : Result := 'NO_DATA_ALLOWED_ERR';
    NO_MODIFICATION_ALLOWED_ERR   : Result := 'NO_MODIFICATION_ALLOWED_ERR';
    NOT_FOUND_ERR                 : Result := 'NOT_FOUND_ERR';
    NOT_SUPPORTED_ERR             : Result := 'NOT_SUPPORTED_ERR';
    INUSE_ATTRIBUTE_ERR           : Result := 'INUSE_ATTRIBUTE_ERR';
    INVALID_STATE_ERR             : Result := 'INVALID_STATE_ERR';
    SYNTAX_ERR                    : Result := 'SYNTAX_ERR';
    INVALID_MODIFICATION_ERR      : Result := 'INVALID_MODIFICATION_ERR';
    NAMESPACE_ERR                 : Result := 'NAMESPACE_ERR';
    INVALID_ACCESS_ERR            : Result := 'INVALID_ACCESS_ERR';
    20                            : Result := 'SaveXMLToMemory_ERR';
    22                            : Result := 'SaveXMLToDisk_ERR';
    100                           : Result := 'LIBXML2_NULL_POINTER_ERR';
    101                           : Result := 'INVALID_NODE_SET_ERR';
    else                            Result := 'unknown error no: ' + IntToStr(code);
  end;
end;

function getErrStr(e: Exception; code: integer = 0): string;
var
  expected,found: string;
  EOle: EOleException;
begin
  result := 'error';
  if e is EDomException then begin
    expected := getCodeStr(code);
    found    := getCodeStr((E as EDomException).code);
    result := Format('wrong exception raised - expected "%s" found "%s"', [expected,found]);
  end else if e is EOleException then begin
    EOle := EOleException(E);
    result := Format('wrong exception raised: %s %x: "%s", "%s"',[EOle.Source, EOle.ErrorCode, EOle.Message, EOle.HelpFile]);
  end else begin
    result := Format('wrong exception raised: %s "%s"',[E.ClassName,E.Message]);
  end;
end;

{ TTestDomExceptions }

procedure TTestDomExceptions.ClearUp;
begin
  elem := nil;
  nnmap := nil;
  attr := nil;
  node := nil;
  select := nil;
  nodelist := nil;
  pci := nil;
  entref := nil;
  ent := nil;
  nota := nil;
  cdata := nil;
  text := nil;
  doc := nil;
  doc1 := nil;
  check(GetDoccount(impl) = 0,'doccount<>0');
  impl := nil;
  prefix := '';
  Name := '';
  nsuri := '';
  Data := '';
  noex := false;
end;

procedure TTestDomExceptions.SetUp;
var
  ADomSetup: IDOMSetup;
  ADocumentBuilder: IDomDocumentBuilder;
begin
  // reset all
  ClearUp;
  ADomSetup := DomSetup.getCurrentDomSetup;
  ADocumentBuilder := ADomSetup.getDocumentBuilder;
  impl := ADocumentBuilder.domImplementation;
  doc := impl.createDocument('', '', nil);
  (doc as IDomPersist).loadxml(xmlstr);
  doc1 := impl.createDocument('', '', nil);
  (doc1 as IDomPersist).loadxml(xmlstr1);
  nsuri := 'http://ns.4commerce.de';
  prefix := 'ct';
  Name := 'test';
  Data := 'Dies ist ein Beispiel-Text.';
  noex := False;
end;

procedure TTestDomExceptions.TearDown;
begin
  // reset all
  ClearUp;
end;

function TTestDomExceptions.getFqname: string;
begin
  if prefix = '' then Result := Name
  else Result := prefix + ':' + Name;
end;

procedure TTestDomExceptions.unknown_selectNodes3;
begin
  select := doc.documentElement as IDomNodeSelect;
  try
    nodelist := select.selectNodes('"');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = SYNTAX_ERR,
          'wrong exception raised: ' + E.Message);
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_AppendAttribute;
var
  attr: IDomAttr;
begin
  attr := doc.createAttribute('test');
  try
    // HIERARCHY_REQUEST_ERR
    doc.documentElement.appendChild(attr);
    fail('There should have been an EDomException');
  except
    on E: Exception do Check(E is EDomException, getErrStr(E));
  end;
end;

procedure TTestDomExceptions.unknown_AppendNilNode;
begin
  try
    doc.documentElement.appendChild(nil);
    fail('There should have been an EDomError');
  except
    on E: Exception do Check(E is EDomException, getErrStr(E));
  end;
end;

procedure TTestDomExceptions.unknown_InsertNilNode;
var
  node: IDomNode;
begin
  node := doc.createElement('sub1');
  doc.documentElement.appendChild(node);
  try
    doc.documentElement.insertBefore(nil, node);
    fail('There should have been an EDomError');
  except
    on E: Exception do Check(E is EDomException, getErrStr(E));
  end;
end;

procedure TTestDomExceptions.hierarchy_InsertAnchestor;
var 
  node1, node2: IDomNode;
begin
  node1 := doc.createElement('sub1');
  node2 := doc.createElement('sub2');
  node1.appendChild(node2);
  doc.documentElement.appendChild(node1);
  try
    node1.insertBefore(doc.documentElement, node2);
    fail('There should have been an EDomError');
  except
    on E: Exception do Check(E is EDomException, getErrStr(E));
  end;
end;

procedure TTestDomExceptions.hierarchy_appendChild1;
begin
  elem := doc.createElement(Name);
  // node is of a type that does not allow children of the type of the newChild node
  try
    elem.appendChild(doc as IDomNode);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_appendChild2;
begin
  elem := doc.createElement(Name);
  doc.documentElement.appendChild(elem);
  // node to append is one of this node's ancestors
  try
    elem.appendChild(doc.documentElement);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_appendChild3;
begin
  elem := doc.createElement(Name);
  // node to append is this node itself
  try
    elem.appendChild(elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.wrongdoc_appendChild4;
var
  doc2: IDomDocument;
begin
  doc2 := impl.createDocument('', '', nil);
  (doc2 as IDomPersist).loadxml(xmlstr);
  elem := doc2.createElement(Name);
  // if newChild was created from a different document
  // than the one that created this node
  try
    doc.documentElement.appendChild(elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = WRONG_DOCUMENT_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.invalidchar_createAttribute1;
var
  i: integer;
  wc: WideChar;
begin
  // the specified name contains an illegal character
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      attr := doc.createAttribute(''+wc);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, getErrStr(E,INVALID_CHARACTER_ERR));
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.invalidchar_createAttributeNS1;
var
  i: integer;
  wc: WideChar;
begin
  // the specified name contains an illegal character
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      attr := doc.createAttributeNS(nsuri, ''+wc);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, getErrStr(E,INVALID_CHARACTER_ERR));
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.invalidchar_createDocument;
var
  i: integer;
  wc: WideChar;
begin
  // the specified name contains an illegal character
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      doc := impl.createDocument('', ''+wc, nil);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, 'wrong exception raised');
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.invalidchar_createElement1;
var
  i: integer;
  wc: WideChar;
begin
  // the specified name contains an illegal character
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      elem := doc.createElement(''+wc);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, 'wrong exception raised');
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.invalidchar_createElementNS1;
var
  i: integer;
  wc: WideChar;
begin
  // the specified name contains an illegal character
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      elem := doc.createElementNS(nsuri, ''+wc);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, 'wrong exception raised');
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.invalidchar_createEntityReference1;
var
  i: integer;
  wc: WideChar;
begin
  // the specified name contains an illegal character
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      entref := doc.createEntityReference(''+wc);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, 'wrong exception raised');
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.invalidchar_setAttribute1;
var
  i: integer;
  wc: WideChar;
begin
  // INVALID_CHARACTER_ERR: Raised if the specified name contains an illegal
  // character.
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      doc.documentElement.setAttribute(''+wc,Data);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, getErrStr(E,INVALID_CHARACTER_ERR));
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.invalidchar_setAttributeNS1;
var
  i: integer;
  wc: WideChar;
begin
  // INVALID_CHARACTER_ERR: Raised if the specified qualified name contains an
  // illegal character, per the XML 1.0 specification [XML].
  for i := 0 to 25 do begin
    wc := illegalChars[i];
    try
      doc.documentElement.setAttributeNS(nsuri,''+wc,Data);
      noex := True;
    except
      on E: Exception do begin
        if E is EDomException then begin
          check((E as EDomException).code = INVALID_CHARACTER_ERR, getErrStr(E,INVALID_CHARACTER_ERR));
        end else begin
          fail(getErrStr(E));
        end;
      end;
    end;
    if noex then fail('exception not raised');
  end;
end;

procedure TTestDomExceptions.namespace_createAttributeNS2;
begin
  // the qualifiedName has a prefix and the namespaceURI is null
  try
    attr := doc.createAttributeNS('', 'ct:test');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createAttributeNS3;
begin
  // the qualifiedName has a prefix that is "xml" and
  // the namespaceURI is different from "http://www.w3.org/XML/1998/namespace"
  try
    attr := doc.createAttributeNS(nsuri, 'xml:test');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createAttributeNS4;
begin
  // the qualifiedName is "xmlns"
  // and the namespaceURI is different from "http://www.w3.org/2000/xmlns/".
  try
    attr := doc.createAttributeNS(nsuri, 'xmlns');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createAttributeNS5;
begin
  // the prefix is "xmlns"
  // and the namespaceURI is different from "http://www.w3.org/2000/xmlns/".
  try
    attr := doc.createAttributeNS(nsuri, 'xmlns:test');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createAttributeNS6;
begin
  // maybe we have a malformed qualifiedName
  // we don't. this creates a default namespace. Fe.
  check(true);
  (*
  try
    attr := doc.createAttributeNS('http://abc.org','test');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then begin
    attr.value := Data;
    doc.documentElement.setAttributeNodeNS(attr);
    debugDom(doc);
    fail('exception not raised');
  end;
  *)
end;

procedure TTestDomExceptions.namespace_createDocument1;
begin
  // the qualifiedName has a prefix and the namespaceURI is null
  try
    doc := impl.createDocument('', fqname, nil);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createDocument2;
begin
  // the qualifiedName is null and the namespaceURI is different from null
  try
    doc := impl.createDocument(nsuri, '', nil);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createDocument3;
begin
  // the qualifiedName has a prefix that is "xml" and
  // the namespaceURI is different from "http://www.w3.org/XML/1998/namespace"
  try
    doc := impl.createDocument(nsuri, 'xml:test', nil);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createElementNS2;
begin
  // the qualifiedName has a prefix and the namespaceURI is null
  try
    elem := doc.createElementNS('', fqname);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createElementNS3;
begin
  // the qualifiedName has a prefix that is "xml" and
  // the namespaceURI is different from "http://www.w3.org/XML/1998/namespace"
  try
    elem := doc.createElementNS(nsuri, 'xml:test');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_createElementNS4;
begin
  //  we defined a default namespace ... !
  check(true);
  (*
  try
    elem := doc.createElementNS('http://abc.org', 'test');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then begin
    doc.documentElement.appendChild(elem);
    debugDom(doc);
    fail('exception not raised');
  end;
  *)
end;

procedure TTestDomExceptions.invalidchar_createProcessingInstruction1;
begin
  // the specified name contains an illegal character
  try
    pci := doc.createProcessingInstruction('!@#"', Data);
    //don't know, what an illegal character in the target is
    //noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INVALID_CHARACTER_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then  fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_insertBefore1;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  elem.appendChild(node);
  // node is of a type that does not allow children of the type of the newChild node
  try
    elem.insertBefore(doc as IDomNode, node);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_insertBefore2;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  elem.appendChild(node);
  doc.documentElement.appendChild(elem);
  // node to insert is one of this node's ancestors
  try
    elem.insertBefore(doc.documentElement, node);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_insertBefore3;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  elem.appendChild(node);
  // node to insert is this node itself
  try
    elem.insertBefore(elem, node);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_insertBefore4;
begin
  elem := doc.createElement(Name);
  // node if of type Document and the DOM application
  // attempts to insert a second Element node
  try
    doc.insertBefore(elem, doc.documentElement);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, 'wrong exception raised');
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.wrongdoc_insertBefore5;
begin
  elem := doc.createElement(Name);
  node := doc1.createElement(Name);
  doc.documentElement.appendChild(elem);
  // WRONG_DOCUMENT_ERR: Raised if newChild was created from a different document
  // than the one that created this node
  try
    doc.documentElement.insertBefore(node,elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = WRONG_DOCUMENT_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.notfound_insertBefore6;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  // NOT_FOUND_ERR: Raised if refChild is not a child of this node.
  try
    doc.documentElement.insertBefore(node,elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NOT_FOUND_ERR, getErrStr(E,NOT_FOUND_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.notfound_removeChild1;
begin
  elem := doc.createElement(Name);
  // NOT_FOUND_ERR: Raised if oldChild is not a child of this node.
  try
    doc.documentElement.removeChild(elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NOT_FOUND_ERR, getErrStr(E,NOT_FOUND_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_removeChild2;
begin
  attr := doc.createAttribute(Name);
  // HIERARCHY_REQUEST_ERR: Raised if this node is of a type that does not allow
  // children of the type of the newChild node
  try
    doc.appendChild(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_replaceChild1;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  elem.appendChild(node);
  doc.documentElement.appendChild(elem);
  // HIERARCHY_REQUEST_ERR: Raised if the node to put in is one
  // of this node's ancestors or this node itself.
  try
    elem.replaceChild(doc.documentElement,node);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.wrongdoc_replaceChild2;
begin
  elem := doc.createElement(Name);
  node := doc1.createElement(Name);
  doc.documentElement.appendChild(elem);
  // WRONG_DOCUMENT_ERR: Raised if newChild was created from a different document
  // than the one that created this node.
  try
    doc.documentElement.replaceChild(node,elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = WRONG_DOCUMENT_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.notfound_replaceChild3;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  // NOT_FOUND_ERR: Raised if oldChild is not a child of this node.
  try
    doc.documentElement.replaceChild(node,elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NOT_FOUND_ERR, getErrStr(E,NOT_FOUND_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.notfound_removeNamedItem1;
begin
  elem := doc.createElement(Name);
  elem.setAttribute(Name,Data);
  nnmap := elem.attributes;
  // NOT_FOUND_ERR: Raised if there is no node named name in this map.
  try
    nnmap.removeNamedItem('X');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NOT_FOUND_ERR, getErrStr(E,NOT_FOUND_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.notfound_removeNamedItemNS2;
begin
  elem := doc.createElementNS(nsuri,fqname);
  elem.setAttributeNS(nsuri,fqname,Data);
  nnmap := elem.attributes;
  // NOT_FOUND_ERR: Raised if there is no node with the specified namespaceURI
  // and localName in this map.
  try
    nnmap.removeNamedItemNS(nsuri,'X');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NOT_FOUND_ERR, getErrStr(E,NOT_FOUND_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.notfound_removeNamedItemNS3;
begin
  elem := doc.createElementNS(nsuri,fqname);
  elem.setAttributeNS(nsuri,fqname,Data);
  nnmap := elem.attributes;
  // NOT_FOUND_ERR: Raised if there is no node with the specified namespaceURI
  // and localName in this map.
  try
    nnmap.removeNamedItemNS('X',Name);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NOT_FOUND_ERR, getErrStr(E,NOT_FOUND_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.wrongdoc_setNamedItem1;
begin
  elem := doc.createElement(Name);
  elem.setAttribute(Name,Data);
  attr := doc1.createAttribute(Name);
  nnmap := elem.attributes;
  // WRONG_DOCUMENT_ERR: Raised if arg was created from a different document than
  // the one that created this map.
  try
    nnmap.setNamedItem(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = WRONG_DOCUMENT_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.inuse_setNamedItem2;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  elem.setAttribute(Name,Data);
  //doc.documentElement.appendChild(elem);
  attr := elem.getAttributeNode(Name);
  nnmap := node.attributes;
  // INUSE_ATTRIBUTE_ERR: Raised if arg is an Attr that is already an attribute
  // of another Element object. The DOM user must explicitly clone Attr nodes to
  // re-use them in other elements.
  try
    nnmap.setNamedItem(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INUSE_ATTRIBUTE_ERR, getErrStr(E,INUSE_ATTRIBUTE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_setNamedItem3;
begin
  elem := doc.createElement(Name);
  node := doc.createElement(Name);
  elem.setAttribute(Name,Data);
  nnmap := elem.attributes;
  // HIERARCHY_REQUEST_ERR: Raised if an attempt is made to add a node doesn't
  // belong in this NamedNodeMap. Examples would include trying to insert
  // something other than an Attr node into an Element's map of attributes.
  try
    nnmap.setNamedItem(node);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_setNamedItem4;
begin
  // entities are read only in DOM Level 2 !!!
  if doc.docType<>nil
    then nnmap := doc.docType.entities;
  {
  elem := doc.createElement(Name);
  // HIERARCHY_REQUEST_ERR: Raised if an attempt is made to add a node doesn't
  // belong in this NamedNodeMap. Examples would include trying to insert
  // a non-Entity node into the DocumentType's map of Entities.
  try
    nnmap.setNamedItem(elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
  }
end;

procedure TTestDomExceptions.wrongdoc_setNamedItemNS1;
begin
  elem := doc.createElementNS(nsuri,fqname);
  elem.setAttributeNS(nsuri,fqname,Data);
  nnmap := elem.attributes;
  attr := doc1.createAttributeNS(nsuri,fqname+'1');
  // WRONG_DOCUMENT_ERR: Raised if arg was created from a different document
  // than the one that created this map.
  try
    nnmap.setNamedItem(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = WRONG_DOCUMENT_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.inuse_setNamedItemNS2;
begin
  elem := doc.createElementNS(nsuri,fqname);
  elem.setAttributeNS(nsuri,fqname+'0',Data);
  nnmap := elem.attributes;
  node := doc.createElementNS(nsuri,fqname);
  attr := doc.createAttributeNS(nsuri,fqname+'1');
  (node as IDOMElement).setAttributeNodeNS(attr);
  // INUSE_ATTRIBUTE_ERR: Raised if arg is an Attr that is already an attribute
  // of another Element object. The DOM user must explicitly clone Attr nodes
  // to re-use them in other elements.
  try
    nnmap.setNamedItem(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code =  INUSE_ATTRIBUTE_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_setNamedItemNS3;
begin
  elem := doc.createElementNS(nsuri,fqname);
  node := doc.createElementNS(nsuri,fqname);
  elem.setAttributeNS(nsuri,fqname,Data);
  nnmap := elem.attributes;
  // HIERARCHY_REQUEST_ERR: Raised if an attempt is made to add a node doesn't
  // belong in this NamedNodeMap. Examples would include trying to insert
  // something other than an Attr node into an Element's map of attributes.
  try
    nnmap.setNamedItem(node);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.hierarchy_setNamedItemNS4;
begin
  // entities are read only in DOM Level 2 !!!
  if doc.docType<>nil
    then nnmap := doc.docType.entities;
  {
  elem := doc.createElementNS(nsuri,fqname);
  // HIERARCHY_REQUEST_ERR: Raised if an attempt is made to add a node doesn't
  // belong in this NamedNodeMap. Examples would include trying to insert
  // a non-Entity node into the DocumentType's map of Entities.
  try
    nnmap.setNamedItemNS(elem);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = HIERARCHY_REQUEST_ERR, getErrStr(E,HIERARCHY_REQUEST_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
  }
end;

procedure TTestDomExceptions.index_deleteData1;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is negative
  try
    cdata.deleteData(-1,1);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_deleteData2;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is greater than the number
  // of 16-bit units in data
  try
    cdata.deleteData(Length(Data)+100,1);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_deleteData3;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified count is negative.
  try
    cdata.deleteData(0,-1);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_insertData1;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is negative
  try
    cdata.insertData(-1,Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_insertData2;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is greater than the number
  // of 16-bit units in data.
  try
    cdata.insertData(Length(Data)+100,Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_replaceData1;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is negative
  try
    cdata.replaceData(-1,1,Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_replaceData2;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is greater than the number
  // of 16-bit units in data
  try
    cdata.replaceData(Length(Data)+100,1,Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_replaceData3;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified count is negative.
  try
    cdata.replaceData(1,-1,Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_substringData1;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is negative
  try
    Data := cdata.subStringData(-1,1);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_substringData2;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is greater than the number
  // of 16-bit units in data
  try
    Data := cdata.subStringData(Length(Data)+100,1);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_substringData3;
begin
  cdata := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified count is negative.
  try
    Data := cdata.subStringData(1,-1);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.notfound_removeAttributeNode1;
begin
  attr := doc.createAttribute(Name);
  // NOT_FOUND_ERR: Raised if oldAttr is not an attribute of the element.
  try
    doc.documentElement.removeAttributeNode(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NOT_FOUND_ERR, getErrStr(E,NOT_FOUND_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_setAttributeNS2;
begin
  // NAMESPACE_ERR: Raised if the qualifiedName has a prefix and the
  // namespaceURI is null
  try
    doc.documentElement.setAttributeNS('',fqname,Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_setAttributeNS3;
begin
  // NAMESPACE_ERR: Raised if the qualifiedName has a prefix that is "xml" and
  // the namespaceURI is different from "http://www.w3.org/XML/1998/namespace"
  try
    doc.documentElement.setAttributeNS('http://somedomain.invalid/namespace','xml:lang',Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_setAttributeNS4;
begin
  // NAMESPACE_ERR: Raised if its prefix is "xmlns" and the namespaceURI is
  // different from "http://www.w3.org/2000/xmlns/".
  try
    doc.documentElement.setAttributeNS('http://somedomain.invalid/namespace','xmlns:ct',Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_setAttributeNS5;
begin
  // NAMESPACE_ERR: Raised if the qualifiedName is "xmlns" and the namespaceURI
  // is different from "http://www.w3.org/2000/xmlns/".
  try
    doc.documentElement.setAttributeNS('http://somedomain.invalid/namespace','xmlns',Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_setAttributeNS6;
begin
  // maybe we have a malformed qualifiedName ... ?
  // no, we just set a default namespace. Fe.
  check(true);
  (*
  try
    doc.documentElement.setAttributeNS('http://abc.org','test',Data);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NAMESPACE_ERR, getErrStr(E,NAMESPACE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then begin
    debugDom(doc);
    fail('exception not raised');
  end;
  *)
end;

procedure TTestDomExceptions.wrongdoc_setAttributeNode1;
begin
  attr := doc1.createAttribute(Name);
  // WRONG_DOCUMENT_ERR: Raised if newAttr was created from a different document
  // than the one that created the element.
  try
    doc.documentElement.setAttributeNode(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = WRONG_DOCUMENT_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.inuse_setAttributeNode2;
begin
  attr := doc.createAttribute(Name);
  elem := doc.createElement(Name);
  elem.setAttributeNode(attr);
  // INUSE_ATTRIBUTE_ERR: Raised if newAttr is already an attribute of another
  // Element object. The DOM user must explicitly clone Attr nodes to re-use
  // them in other elements.
  try
    doc.documentElement.setAttributeNode(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INUSE_ATTRIBUTE_ERR, getErrStr(E,INUSE_ATTRIBUTE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;



procedure TTestDomExceptions.wrongdoc_setAttributeNodeNS1;
begin
  attr := doc1.createAttributeNS(nsuri,fqname);
  // WRONG_DOCUMENT_ERR: Raised if newAttr was created from a different document
  // than the one that created the element.
  try
    doc.documentElement.setAttributeNodeNS(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = WRONG_DOCUMENT_ERR, getErrStr(E,WRONG_DOCUMENT_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.inuse_setAttributeNodeNS2;
begin
  attr := doc.createAttributeNS(nsuri,fqname);
  elem := doc.createElementNS(nsuri,fqname);
  elem.setAttributeNodeNS(attr);
  // INUSE_ATTRIBUTE_ERR: Raised if newAttr is already an attribute of another
  // Element object. The DOM user must explicitly clone Attr nodes to re-use
  // them in other elements.
  try
    doc.documentElement.setAttributeNodeNS(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INUSE_ATTRIBUTE_ERR, getErrStr(E,INUSE_ATTRIBUTE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_splitText1;
begin
  text := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is negative
  try
    text.splitText(-1);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.index_splitText2;
begin
  text := doc.createTextNode(Data);
  // INDEX_SIZE_ERR: Raised if the specified offset is greater than the number
  // of 16-bit units in data.
  try
    text.splitText(Length(data)+100);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = INDEX_SIZE_ERR, getErrStr(E,INDEX_SIZE_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.namespace_already_bound_prefix_setAttributeNS;
begin
  elem := doc.createElement(Name);
  elem.setAttributeNS('http://abc.org','abc:test',Data);
  // this is allowed because the prefix 'abc' is only used for
  // output streaming. internal this node is identified
  // by localname and namespaceURI
  elem.setAttributeNS('http://def.org','abc:zebra',Data);
end;

procedure TTestDomExceptions.namespace_already_bound_prefix_setAttributeNodeNS;
begin
  elem := doc.createElement(Name);
  attr := doc.createAttributeNS('http://abc.org','abc:test');
  elem.setAttributeNodeNS(attr);
  attr := doc.createAttributeNS('http://def.org','abc:zebra');
  // this is allowed because the prefix 'abc' is only used for
  // output streaming. internal this node is identified
  // by localname and namespaceURI
  elem.setAttributeNodeNS(attr);
end;

procedure TTestDomExceptions.namespace_already_bound_prefix_createElementNS;
begin
  // it is ok that a child of an element binds a prefix
  // to another namespace uri than the element does
  elem := doc.createElementNS('http://abc.org','abc:test');
  doc.documentElement.appendChild(elem);
  elem := doc.createElementNS('http://def.org','abc:def');
  doc.documentElement.firstChild.appendChild(elem);
end;

procedure TTestDomExceptions.readonly_value;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  //debugAttributes(nnmap);
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised when the node is readonly
    attr.value := 'non-fixed-value';
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_removeNamedItem_attr;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised when the node is readonly
    nnmap.removeNamedItem('attr-fixed');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_nodeValue;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  node := nnmap.namedItem['attr-fixed'] as IDOMNode;
  check(node <> nil, 'node is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised when the node is readonly
    node.nodeValue := 'non-fixed-value';
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_removeNamedItem_entity;
begin
  check((doc as IDOMPersist).loadxml(xmlstr2),'parse error');
  nnmap := doc.docType.entities;
  check(nnmap <> nil, 'entities are nil');
  check(nnmap.length = 2, 'wrong length');
  ent := nnmap.namedItem['ct'] as IDOMEntity;
  check(ent <> nil, 'entity is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this map is readonly
    nnmap.removeNamedItem('ct');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_removeNamedItem_notation;
begin
  check((doc as IDOMPersist).loadxml(xmlstr2),'parse error');
  nnmap := doc.docType.notations;
  check(nnmap <> nil, 'notations are nil');
  check(nnmap.length = 1, 'wrong length');
  nota := nnmap.namedItem['type2'] as IDOMNotation;
  check(nota <> nil, 'notation is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this map is readonly
    nnmap.removeNamedItem('type2');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_removeNamedItemNs_attr;
begin
{ TODO : use xmlstr5 here }
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.getNamedItemNS('','attr-fixed') as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR
    nnmap.removeNamedItemNS('','attr-fixed');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_setNamedItem_attr;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  attr := doc.createAttribute('attr-fixed');
  attr.value := 'non-fixed-value';
  try
    // NO_MODIFICATION_ALLOWED_ERR
    nnmap.setNamedItem(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_setNamedItemNs_attr;
const
  xmlstr4 = xmldecl +
            '<!DOCTYPE root [' +
            '<!ELEMENT root (#PCDATA)>' +
            '<!ATTLIST root attr-implied  CDATA #IMPLIED>' +
            '<!ATTLIST root attr-default  CDATA "default-value">' +
            '<!ATTLIST root attr-required CDATA #REQUIRED>' +
            '<!ATTLIST root attr-fixed    CDATA #FIXED "fixed-value">' +
            ']>' +
            '<root attr-required="required-value" />';
begin
{ TODO : use xmlstr5 here }
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.getNamedItemNS('','attr-fixed') as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  attr := doc.createAttributeNS('','attr-fixed');
  attr.value := 'non-fixed-value';

  try
    // NO_MODIFICATION_ALLOWED_ERR
    nnmap.setNamedItemNS(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');

end;

procedure TTestDomExceptions.readonly_removeAttribute;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.removeAttribute('attr-fixed');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_removeAttributeNS;
begin
{ TODO : use xmlstr5 here }
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.getNamedItemNS('','attr-fixed') as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.removeAttributeNS('','attr-fixed');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_removeAttributeNode;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.removeAttributeNode(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_setAttribute;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.setAttribute('attr-fixed','non-fixed-value');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_setAttributeNS;
begin
{ TODO : use xmlstr5 here }
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.getNamedItemNS('','attr-fixed') as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.setAttributeNS('','attr-fixed','non-fixed-value');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_setAttributeNode;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  attr := doc.createAttribute('attr-fixed');
  attr.value := 'non-fixed-value';
  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.setAttributeNode(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

procedure TTestDomExceptions.readonly_setAttributeNodeNS;
// DTDs are not intented to work with namespaces, but msxml and libxml2
// can handles the following kind of declaration
const
  xmlstr5 = xmldecl +
            '<!DOCTYPE root [' +
            '<!ELEMENT root (#PCDATA)>' +
            '<!ATTLIST root xmlns:abc         CDATA #FIXED "http://ABC">'+
            '<!ATTLIST root abc:attr-implied  CDATA #IMPLIED>' +
            '<!ATTLIST root abc:attr-default  CDATA "default-value">' +
            '<!ATTLIST root abc:attr-fixed    CDATA #FIXED "fixed-value">' +
            ']>' +
            '<root />';
begin
  (doc as IDOMParseOptions).validate := True;
  check((doc as IDOMPersist).loadxml(xmlstr5),'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length');

  attr := nnmap.getNamedItemNS('http://ABC','attr-fixed') as IDOMAttr;

  check(attr <> nil, 'attribute is nil');

  attr := doc.createAttributeNS('http://ABC','attr-fixed');
  attr.value := 'non-fixed-value';

  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.setAttributeNodeNS(attr);
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');

end;

procedure TTestDomExceptions.readonly_setAttributeNS1;
const
  xmlstr = xmldecl+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (#PCDATA) >'+CRLF+
           '<!ATTLIST test xmlns:abc CDATA #FIXED "http://abc.org" >'+CRLF+
           '<!ATTLIST test abc:value CDATA #FIXED "def" >'+CRLF+
           ']>'+CRLF+
           '<test />';
var
  temp: string;
begin
  (doc as IDOMParseOptions).validate := True;
  check((doc as IDOMPersist).loadxml(xmlstr),'parse error');
  nnmap := doc.documentElement.attributes;
  temp := doc.documentElement.getAttributeNS('http://abc.org','value');

  check( temp = 'def', 'wrong value');

  try
    // NO_MODIFICATION_ALLOWED_ERR: Raised if this node is readonly
    doc.documentElement.setAttributeNS('http://abc.org','abc:value','ghi');
    noex := True;
  except
    on E: Exception do begin
      if E is EDomException then begin
        check((E as EDomException).code = NO_MODIFICATION_ALLOWED_ERR, getErrStr(E,NO_MODIFICATION_ALLOWED_ERR));
      end else begin
        fail(getErrStr(E));
      end;
    end;
  end;
  if noex then fail('exception not raised');
end;

initialization
  datapath := getDataPath;

  {$ifdef win32}
  CoInitialize(nil);
  {$endif}
  {$ifdef linux}
  ;
  {$endif}

end.
