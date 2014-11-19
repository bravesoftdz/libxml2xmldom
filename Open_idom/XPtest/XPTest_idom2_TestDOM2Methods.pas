unit XPTest_idom2_TestDOM2Methods;

{$MODE Delphi}

interface

uses
  libxmldom,
  idom2,
  idom2_ext,
  SysUtils,
  ActiveX,
  XPTest_idom2_Shared,
  Classes,
  Dialogs;


type
  TTestDOM2Methods = class(TMyTestCase)
  private
    impl: IDomImplementation;
    doc0: IDomDocument;
    doc1: IDomDocument;
    doc: IDomDocument;
    node: IDomNode;
    elem: IDomElement;
    attr: IDomAttr;
    Text: IDomText;
    nodelist: IDomNodeList;
    cdata: IDomCDATASection;
    comment: IDomComment;
    pci: IDomProcessingInstruction;
    docfrag: IDomDocumentFragment;
    ent: IDomEntity;
    entref: IDomEntityReference;
    nota: IDOMNotation;
    select: IDomNodeSelect;
    nnmap: IDomNamedNodeMap;
    nsuri: string;
    prefix: WideString;
    Name: WideString;
    Data: WideString;
    function getFqname: WideString;
    function getFragmentA(out docstr: WideString): IDOMElement;
  public
    procedure ClearUp;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // a leading "basic" indicates that only properties are tested
    // a trailing "10times" indicates that the basic tests are done for 10 diffenent property values
    // a leading "unknown" indicates that we have to discuss this test
    // a trailing "setNodeValue" indicates that a nodeValue is set where it schould have no effect
    // a leading "ext" indicates that the basic test was extended
    procedure basic_appendChild;
    procedure basic_cloneNode_AttributeNode;
    procedure basic_cloneNode_AttributeNodeNS;
    procedure basic_cloneNode_AttributeNS_on_element_deep;
    procedure basic_cloneNode_AttributeNS_on_element_flat;
    procedure basic_cloneNode_Attribute_on_element_deep;
    procedure basic_cloneNode_Attribute_on_element_flat;
    procedure basic_cloneNode_CDATA_deep;
    procedure basic_cloneNode_Comment_deep;
    procedure basic_cloneNode_DocumentFragment;
    procedure basic_cloneNode_ElementNS_deep;
    procedure basic_cloneNode_ElementNS_flat;
    procedure basic_cloneNode_Element_AttrNS_flat;
    procedure basic_cloneNode_Element_deep;
    procedure basic_cloneNode_Element_flat;
//    procedure basic_cloneNode_NodeList_deep;
    procedure basic_cloneNode_ProcessingInstruction;
    procedure basic_cloneNode_TextNode_deep;
    procedure basic_createAttribute;
    procedure basic_createAttributeNS;
    procedure basic_createAttributeNS_createNsDecl;
    procedure basic_createCDATASection;
    procedure basic_createComment;
    procedure basic_createDocumentFragment;
    procedure basic_createElement;
    procedure basic_createElementNS;
    procedure basic_createEntityReference;
    procedure basic_createProcessingInstruction;
    procedure basic_createTextNode;
    procedure basic_docType;
    procedure basic_document;
    procedure basic_documentElement;
    procedure basic_documentFragment;
    procedure basic_domImplementation;
    procedure basic_firstChild;
    procedure basic_getAttributeNodeNS_setAttributeNodeNS;
    procedure basic_getAttributeNS_setAttributeNS;
    procedure basic_getAttribute_setAttribute;
    procedure basic_getElementByID;
    procedure basic_getElementsByTagName;
    procedure basic_getElementsByTagNameNS;
    procedure basic_hasAttributeNS_setAttributeNodeNS;
    procedure basic_hasAttributes_setAttribute;
    procedure basic_hasAttribute_setAttributeNode;
    procedure basic_hasChildNodes;
    procedure basic_importNode_AttributeNode;
    procedure basic_importNode_AttributeNodeNS;
    procedure basic_importNode_AttributeNodeNS_on_element;
    procedure basic_importNode_AttributeNode_on_element;
    procedure basic_importNode_CDataSection;
    procedure basic_importNode_CommentNode;
    procedure basic_importNode_DocumentFragment_deep;
    procedure basic_importNode_DocumentFragment_flat;
    procedure basic_importNode_Element_deep_flat;
    procedure basic_importNode_ElementNS_deep_flat;
    procedure basic_importNode_ProcessingInstruction;
    procedure basic_importNode_TextNode;
    procedure basic_insertBefore;
    procedure basic_isSupported;
    procedure basic_lastChild;
    procedure basic_nsdecl;
    procedure basic_ownerElement;
    procedure basic_removeAttribute;
    procedure basic_removeAttributeNode;
    procedure basic_removeAttributeNS;
    procedure basic_removeChild;
    procedure basic_replaceChild;
    procedure ext_appendAttributeNodeNS_removeAttributeNode;
    procedure ext_appendChild_10times;
    procedure ext_appendChild_existing;
    procedure ext_appendChild_NsDecl;
    procedure ext_appendChild_orphan;
    procedure ext_appendChild_removeChild;
    procedure ext_append_100_attributes_with_different_namespaces;
    procedure ext_attributes_10times;
    procedure ext_attribute_default2;
    procedure ext_attribute_default3;
    procedure ext_attribute_default4;
    procedure ext_attribute_default5;
    procedure ext_attribute_default_removeNamedItem;
    procedure ext_attribute_default_getAttribute;
    procedure ext_attribute_default_getAttributeNode;
    procedure ext_attribute_default_getAttributeNodeNS;
    procedure ext_attribute_default_getAttributeNS;
    procedure ext_attribute_default_modify;
    procedure ext_attribute_default_removeNamedItemNS;
    procedure ext_attribute_specified;
    procedure ext_checkIgnoreDocumentProcessInstruction;
    procedure ext_cloneNode_AttributeNode_default;
    procedure ext_cloneNode_AttributeNode_default_on_Element;
    procedure ext_cloneNode_document;
    procedure ext_cloneNode_documentNS;
    procedure ext_cloneNode_getFragmentA;
    procedure ext_cloneNode_NsDecl;
    procedure ext_createElementNS_defaultNS;
    procedure ext_docType;
    procedure ext_docType_entities1;
    procedure ext_docType_entities2;
    procedure ext_docType_entities;
    procedure ext_docType_entities_externalDTD;
    procedure ext_docType_entities_external_internalDTD;
    procedure ext_docType_notations;
    procedure ext_docType_notations_externalDTD;
    procedure ext_document_setNodeValue;
    procedure ext_element_setNodeValue;
    procedure ext_getAttribute;
    procedure ext_getAttributeNodeNS;
    procedure ext_getAttributeNode_setAttributeNode;
    procedure ext_getAttributeNS;
    procedure ext_getElementsByTagName;
    procedure ext_getElementsByTagNameNS;
    procedure ext_getElementsByTagNameNS_10times;
    procedure ext_importNode_AttributeNodeNS_default;
    procedure ext_importNode_AttributeNode_default;
    procedure ext_importNode_AttributeNode_default_on_element;
    procedure ext_importNode_cloneNode;
    procedure basic_importNode_AttributeNode1;
    procedure basic_importNode_AttributeNodeNS1;
    procedure ext_insertBefore_10times;
    procedure ext_insertBefore_documentFragment;
    procedure ext_insertBefore_existing;
    procedure ext_insertBefore_TextNode;
    procedure ext_namedNodeMap;
    procedure ext_namedNodeMapNS;
    procedure ext_namedNodeMap_append_remove_NsDecl1;
    procedure ext_namedNodeMap_append_remove_NsDecl2;
    procedure ext_nextSibling_10times;
    procedure ext_nsdecl;
    procedure ext_previousSibling_10times;
    procedure ext_reconciliate1;
    procedure ext_reconciliate;
    procedure ext_removeAttributeNs;
    procedure ext_setAttributeNodeNs_NsDecl;
    procedure ext_setAttributeNodeNS_Xml;
    procedure ext_setAttributeNS;
    procedure ext_setAttributeNS_removeAttributeNS;
    procedure ext_setNamedItemNS_Xml;
    procedure ext_TestDocCount;
    procedure ext_unicode_NodeName;
    procedure ext_unicode_TextNodeValue;
    procedure unknown_createElementNS;
    procedure unknown_createElementNS_1;
    procedure unknown_normalize;
    procedure unknown_normalize_deep;
    procedure unknown_normalize_emptyTextNodes;
    procedure unknown_normalize_flat;
    procedure unknown_normalize_mix;
    procedure unknown_PrettyPrint1;
    procedure unknown_PrettyPrint;
    property fqname: WideString read getFqname;

  end;

implementation

uses domSetup;

const
  S_OK = 0;

{ TTestDom2Methods }

// clear and reset all local vars to make sure that mem compare
// could make sense
procedure TTestDom2Methods.ClearUp;
begin
  nota := nil;
  node := nil;
  elem := nil;
  attr := nil;
  Text := nil;
  nodelist := nil;
  cdata := nil;
  comment := nil;
  pci := nil;
  docfrag := nil;
  entref := nil;
  ent := nil;
  select := nil;
  nnmap := nil;
  doc := nil;
  doc0 := nil;
  doc1 := nil;
  impl := nil;
  nsuri := '';
  prefix := '';
  Name := '';
  Data := '';
end;

procedure TTestDom2Methods.SetUp;
var
  ADomSetup: IDOMSetup;
  ADocumentBuilder: IDomDocumentBuilder;
begin
  // reset all
  ClearUp;

  // init all
  ADomSetup := DomSetup.getCurrentDomSetup;
  ADocumentBuilder := ADomSetup.getDocumentBuilder;
  impl := ADocumentBuilder.domImplementation;
  doc0 := impl.createDocument('', '', nil);
  (doc0 as IDomPersist).loadxml(xmlstr);
  doc1 := impl.createDocument('', '', nil);
  (doc1 as IDomPersist).loadxml(xmlstr1);
  doc := impl.createDocument('', '', nil);
  (doc as IDomPersist).loadxml('<?xml version="1.0" encoding="iso-8859-1"?><root />');
  nsuri := 'http://ns.4commerce.de';
  prefix := 'ct'+getUnicodeStr(1);
  Name := 'test'+getUnicodeStr(1);
  Data := 'Dies ist ein Beispiel-Text.'+getUnicodeStr(1);
end;

procedure TTestDom2Methods.TearDown;
begin
  // reset all
  ClearUp;
end;

procedure TTestDom2Methods.ext_TestDocCount;
begin
  check((GetDoccount(impl) = 3),'Doccount not supported!');
  doc0 := nil;
  doc1 := nil;
  doc := nil;
  check(GetDoccount(impl) = 0,'documents not released');
end;

procedure TTestDom2Methods.ext_appendChild_existing;
var
  node: IDomNode;
  temp: string;
begin
  check(doc0.documentElement.childNodes.length = 0, 'wrong length (A)');
  node := doc0.createElement('sub1');
  doc0.documentElement.appendChild(node);
  check(doc0.documentElement.childNodes.length = 1, 'wrong length (B)');
  doc0.documentElement.appendChild(node);
  // DOM2: If the child is already in the tree, it is first removed. So there
  // must be only one child sub1 after the two calls of appendChild
  check(doc0.documentElement.childNodes.length = 1, 'wrong length');
  temp := ((doc0 as IDomPersist).xml);
  temp := unify(temp);
  check(temp = '<test><sub1/></test>', 'appendChild Error');
end;

procedure TTestDom2Methods.basic_getElementByID;
var
  elem: IDomElement;
begin
  elem := doc0.getElementById('110');
end;

procedure TTestDom2Methods.unknown_createElementNS_1;
var
  node: IDomNode;
  temp: string;
begin
  check(doc0.documentElement.childNodes.length = 0, 'wrong length');
  node := doc0.createElementNS('http://ns.4ct.de', 'ct:test');
  doc0.documentElement.appendChild(node);
  check(doc0.documentElement.childNodes.length = 1, 'wrong length');
  // compare the output
  temp := (doc0 as IDomPersist).xml;
  temp := unify(temp);
  check((
         (temp = '<test><ct:test xmlns:ct="http://ns.4ct.de"/></test>') or
         (temp = '<test xmlns:ct="http://ns.4ct.de"><ct:test/></test>')
        ),
        'createElementNS failed');
end;

procedure TTestDom2Methods.unknown_createElementNS;
var
  node: IDomNode;
  temp: string;
begin
  check(doc1.documentElement.childNodes.length = 0, 'wrong length');
  node := doc1.createElementNS('http://ns.4ct.de', 'ct:test');
  doc1.documentElement.appendChild(node);
  check(doc1.documentElement.childNodes.length = 1, 'wrong length');
  // compare the output
  temp := (doc1 as IDomPersist).xml;
  temp := unify(temp);
  check((
         (temp = '<test xmlns="http://ns.4ct.de"><ct:test xmlns:ct="http://ns.4ct.de"/></test>') or
         (temp = '<test xmlns="http://ns.4ct.de" xmlns:ct="http://ns.4ct.de"><ct:test/></test>') or
         { THIS IS THE WAY LIBXML2 works in the moment (2002-03-13)}
         (temp = '<test><ct:test xmlns:ct="http://ns.4ct.de"/></test>') or
         { THIS IS THE BEST/OPTMIZED OUTPUT STREAM }
         (temp = '<test xmlns="http://ns.4ct.de"><test/></test>')
        )
        ,
        'createElementNS failed');
end;

procedure TTestDom2Methods.basic_createAttributeNS_createNsDecl;
var
  attr: IDomAttr;
  temp: string;
begin
  // this test failes with libxml2 in the moment
  // that is ok, because we (4ct) don't create ns-decl-attributes
  // manually in our current applications
  check(not doc0.documentElement.hasAttributes, 'has attributes');
  attr := doc0.createAttributeNS('http://ns.4ct.de', 'ct:name1');
  attr.Value := 'hund';
  doc0.documentElement.setAttributeNodeNS(attr);
  check(doc0.documentElement.attributes.length = 1, 'wrong length');
  // get the xml source
  temp := (doc0 as IDomPersist).xml;
  temp := unify(temp);
  check(temp = '<test xmlns:ct="http://ns.4ct.de" ct:name1="hund"/>', 'perhaps namespace declaration attribute twice or missing in the output')
end;

procedure TTestDOM2Methods.ext_reconciliate;
var
  s1,s2: string;
  attr: IDomAttr;
  i:    integer;
begin
  // setup DOM
  doc0 := nil;
  doc0 := impl.createDocument('','',nil);
  doc0.appendChild(doc0.createElementNS('http://xmlns.demo.site', 'demo:ROOT'));
  for i := 0 to 2 do begin
    attr := doc0.createAttributeNS('http://test'+IntToStr(i)+'.invalid','test'+IntToStr(i)+':attr');
    attr.Value := IntToStr(i);
    doc0.documentElement.setAttributeNodeNS(attr);
    attr := nil;
  end;

  // get output
  s1 := (doc0 as IDomPersist).xml;

  // setup DOM
  doc0 := nil;
  doc0 := impl.createDocument('','',nil);
  doc0.appendChild(doc0.createElementNS('http://xmlns.demo.site', 'demo:ROOT'));
  for i := 0 to 2 do begin
    attr := doc0.createAttributeNS('http://test'+IntToStr(i)+'.invalid','test'+IntToStr(i)+':attr');
    attr.Value := IntToStr(i);
    doc0.documentElement.setAttributeNodeNS(attr);
    attr := nil;
  end;

  // get reference output
  s2 := (doc0 as IDomPersist).xml;

  // proof
  check(s1 = s2, 'dom outputs did not match');
end;

procedure TTestDOM2Methods.ext_append_100_attributes_with_different_namespaces;
var
  attr: IDomAttr;
  i:    integer;
  attrval, temp: string;
  ok:   boolean;
begin
  // create attributes
  for i := 0 to 2 do begin
    attr := doc0.createAttributeNS('http://test'+IntToStr(i)+'.invalid','test'+IntToStr(i)+':attr');
    attr.Value := IntToStr(i);
    doc0.documentElement.setAttributeNodeNS(attr);
    attr := nil;
  end;
  temp := (doc0 as IDomPersist).xml;
  temp := Unify(temp);
  ok := False;
  if temp = '<test xmlns:test0="http://test0.invalid" test0:attr="0" xmlns:test1="http://test1.invalid" test1:attr="1" xmlns:test2="http://test2.invalid" test2:attr="2"/>'
    then ok := True;
  if temp = '<test xmlns:test0="http://test0.invalid" xmlns:test1="http://test1.invalid" xmlns:test2="http://test2.invalid" test0:attr="0" test1:attr="1" test2:attr="2"/>'
    then ok := True;
  Check(ok, 'Test failed!');
  // check attributes
  for i := 0 to 2 do begin
    attrval := doc0.documentElement.getAttributeNS('http://test'+IntToStr(i)+'.invalid','attr');
    check(attrval = IntToStr(i),'expected '+IntToStr(i)+' but found '+attrval);
  end;
end;

procedure TTestDom2Methods.basic_appendChild;
var
  temp:         widestring;
  temp1, temp2: widestring;
  diff:         integer;
begin
  elem := doc.createElement(Name);
  doc.documentElement.appendChild(elem);
  check(doc.documentElement.hasChildNodes, 'has no childNodes');
  check(myIsSameNode(elem, doc.documentElement.firstChild), 'wrong node');
  // the same with namespace
  doc:=nil;
  doc := impl.createDocument('', '', nil);
  (doc as IDomPersist).loadxml('<?xml version="1.0" encoding="utf8"?><root />');
  elem := doc.createElementNs(nsuri,fqname);
  doc.documentElement.appendChild(elem);
  // debug
  temp := unify((doc as IDomPersist).xml);
  check(doc.documentElement.hasChildNodes, 'has no childNodes');
  check(myIsSameNode(elem, doc.documentElement.firstChild), 'wrong node');
  elem:=nil;
  elem:=doc.documentElement.firstChild as IDomElement;
  check(elem.namespaceURI=nsuri,'wrong namespace uri');
  check(elem.nodeName=fqname,'wrong fqname');
  // compare the output
  temp := (doc as IDomPersist).xml;
  temp := unify(temp);
  temp1 := temp1+'<root><'+fqname+' xmlns:'+prefix+'="'+nsuri+'"/>'+'</root>';
  temp2 := temp2+'<root><xmlns:'+prefix+'="'+nsuri+'" '+fqname+'/>'+'</root>';
  diff:=compareStr(temp,temp1);
  if diff<>0 then diff:=compareStr(temp,temp2);
  check(diff=0,'wrong resulting xml string');
end;

procedure TTestDom2Methods.ext_attributes_10times;
const
  n = 10;
var
  i: integer;
begin
  elem := doc.createElement(Name);
  for i := 0 to n - 1 do begin
    elem.setAttribute(Name +IntToStr(i), IntToStr(i));
  end;
  check(elem.attributes.length = n, 'wrong length');
  for i := 0 to elem.attributes.length - 1 do begin
    check(elem.attributes.item[i].nodeName = Name +IntToStr(i), 'wrong nodeName');
    check(elem.attributes.item[i].nodeValue = IntToStr(i), 'wrong nodeValue');
    check(elem.attributes.item[i].nodeType = ATTRIBUTE_NODE, 'wrong nodeType');
  end;
end;


procedure TTestDOM2Methods.basic_cloneNode_AttributeNode;
begin
  attr := doc.createAttribute('testAttr');
  doc.documentElement.setAttributeNode(attr);
  node := attr.cloneNode(False);
  check(node <> nil, 'is nil');
  check(not MyIsSameNode(node, attr), 'target and source are the same');
  check(node.nodeName = 'testAttr', 'wrong nodeName');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType');
  check(not node.hasChildNodes, 'has child nodes');
end;

procedure TTestDOM2Methods.basic_cloneNode_AttributeNodeNS;
begin
  attr := doc.createAttributeNS('http://abc.org','abc:attr');
  doc.documentElement.setAttributeNodeNS(attr);
  node := attr.cloneNode(False);
  check(node <> nil, 'is nil');
  check(not MyIsSameNode(node, attr), 'target and source are the same');  
  check(node.nodeName = 'abc:attr', 'wrong nodeName');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType');
  check(node.localName = 'attr', 'wrong localName');
  check(node.namespaceURI = 'http://abc.org', 'wrong namespaceURI');
  check(not node.hasChildNodes, 'has child nodes');
end;

procedure TTestDOM2Methods.basic_cloneNode_AttributeNS_on_element_deep;
begin
  // parameter deep of type boolean
  // If true, recursively clone the subtree under the specified node;
  // if false, clone only the node itself
  // (and its attributes, if it is an Element). (w3c.org)
  // The duplicate node has no parent; (parentNode is null.) (w3c.org)

  elem := doc.createElementNS('http://abc.org','abc:elem');
  elem.setAttributeNS('http://def.org','def:attr','1');
  doc.documentElement.appendChild(elem);
  // check what happend so far
  elem := doc.documentElement.firstChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length');
  attr := elem.getAttributeNodeNS('http://def.org','attr');
  check(attr <> nil, 'attribute does not exist');
  check(attr.name = 'def:attr', 'wrong name (I)');
  check(attr.localName = 'attr', 'wrong localName (I)');
  check(attr.namespaceURI = 'http://def.org', 'wrong namespaceURI (I)');
  check(attr.value = '1', 'wrong value');

  // now clone the node
  node := elem.cloneNode(True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node, elem), 'target and source are the same');
  check(node.parentNode = nil, 'wrong parentNode');
  doc.documentElement.appendChild(node);

  // check whats up now
  elem := doc.documentElement.lastChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length');
  // this was previously used to show an error
  // attr := elem.getAttributeNode('attr');
  // check(attr = nil, 'there is an attribute that should not exist');
  attr := elem.getAttributeNodeNS('http://def.org','attr');
  check(attr <> nil, 'attribute does not exist');
  check(attr.name = 'def:attr', 'wrong name (II)');
  check(attr.localName = 'attr', 'wrong localName (II)');
  check(attr.namespaceURI = 'http://def.org', 'wrong namespaceURI (II)');
  check(attr.value = '1', 'wrong value');
end;

procedure TTestDOM2Methods.basic_cloneNode_AttributeNS_on_element_flat;
begin
  // parameter deep of type boolean
  // If true, recursively clone the subtree under the specified node;
  // if false, clone only the node itself
  // (and its attributes, if it is an Element). (w3c.org)
  // The duplicate node has no parent; (parentNode is null.) (w3c.org)

  elem := doc.createElementNS('http://abc.org','abc:elem');
  elem.setAttributeNS('http://def.org','def:attr','1');
  doc.documentElement.appendChild(elem);

  // check what happend so far
  elem := doc.documentElement.firstChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length');
  attr := elem.getAttributeNodeNS('http://def.org','attr');
  check(attr <> nil, 'attribute does not exist');
  check(attr.name = 'def:attr', 'wrong name (I)');
  check(attr.localName = 'attr', 'wrong localName (I)');
  check(attr.namespaceURI = 'http://def.org', 'wrong namespaceURI (I)');
  check(attr.value = '1', 'wrong value');

  // now clone the node
  node := elem.cloneNode(False);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node, elem), 'target and source are the same');
  check(node.parentNode = nil, 'wrong parentNode');
  doc.documentElement.appendChild(node);

  // check whats up now
  elem := doc.documentElement.lastChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length');
  //attr := elem.getAttributeNode('attr');
  //check(attr = nil, 'there is an attribute that should not exist');
  attr := elem.getAttributeNodeNS('http://def.org','attr');
  check(attr <> nil, 'attribute does not exist');
  check(attr.name = 'def:attr', 'wrong name (II)');
  check(attr.localName = 'attr', 'wrong localName (II)');
  check(attr.namespaceURI = 'http://def.org', 'wrong namespaceURI (II)');
  check(attr.value = '1', 'wrong value');
end;

procedure TTestDOM2Methods.basic_cloneNode_Attribute_on_element_deep;
begin
  // parameter deep of type boolean
  // If true, recursively clone the subtree under the specified node;
  // if false, clone only the node itself
  // (and its attributes, if it is an Element). (w3c.org)
  // The duplicate node has no parent; (parentNode is null.) (w3c.org)

  elem := doc.createElement('elem');
  elem.setAttribute('attr','1');
  doc.documentElement.appendChild(elem);

  // check what happend so far
  elem := doc.documentElement.firstChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length (I)');
  attr := elem.getAttributeNode('attr');
  check(attr <> nil, 'attribute does not exist (I)');
  check(attr.name = 'attr', 'wrong name (I)');
  check(attr.value = '1', 'wrong value (I)');

  // now clone the node
  node := elem.cloneNode(True);
  check(node <> nil, 'node ist nil');
  check(not MyIsSameNode(node, elem), 'target and source are the same');
  check(node.parentNode = nil, 'wrong parentNode');
  doc.documentElement.appendChild(node);

  // check whats up now
  elem := doc.documentElement.lastChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length (II)');
  attr := elem.getAttributeNode('attr');
  check(attr <> nil, 'attribute does not exist (II)');
  check(attr.name = 'attr', 'wrong name (II)');
  check(attr.value = '1', 'wrong value (II)');
end;

procedure TTestDOM2Methods.basic_cloneNode_Attribute_on_element_flat;
begin
  // parameter deep of type boolean
  // If true, recursively clone the subtree under the specified node;
  // if false, clone only the node itself
  // (and its attributes, if it is an Element). (w3c.org)
  // The duplicate node has no parent; (parentNode is null.) (w3c.org)

  elem := doc.createElement('elem');
  elem.setAttribute('attr','1');
  doc.documentElement.appendChild(elem);

  // check what happend so far
  elem := doc.documentElement.firstChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length (I)');
  attr := elem.getAttributeNode('attr');
  check(attr <> nil, 'attribute does not exist (I)');
  check(attr.name = 'attr', 'wrong name (I)');
  check(attr.value = '1', 'wrong value (I)');

  // now clone the node
  node := elem.cloneNode(False);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node, elem), 'target and source are the same');
  check(node.parentNode = nil, 'wrong parentNode');
  doc.documentElement.appendChild(node);

  // check whats up now
  elem := doc.documentElement.lastChild as IDOMElement;
  check(elem.attributes.length = 1, 'wrong length (II)');
  attr := elem.getAttributeNode('attr');
  check(attr <> nil, 'attribute does not exist (II)');
  check(attr.name = 'attr', 'wrong name (II)');
  check(attr.value = '1', 'wrong value (II)');
end;

procedure TTestDOM2Methods.basic_cloneNode_ElementNS_deep;
begin
  // scenario:
  // element1.element2.attribute
  // clone element1
  // check if element2 and attribute are cloned too

  elem := doc.createElementNS('http://def.org','def:elem');
  doc.documentElement.appendChild(elem);
  node := doc.createElementNS('http://abc.org','abc:child');
  elem.appendChild(node);
  attr := doc.createAttributeNS('http://ghi.org','ghi:attr');
  (node as IDOMElement).setAttributeNodeNS(attr);

  // now clone the node deep
  node := elem.cloneNode(True);
  check(node <> nil, 'node does not exist');
  check(not MyIsSameNode(node, elem), 'target and source are the same');
  check(node.nodeName = 'def:elem', 'wrong nodeName (I)');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType (I)');
  check(node.localName = 'elem', 'wrong localName (I)');
  check(node.namespaceURI = 'http://def.org', 'wrong namespaceURI (I)');
  check(node.hasChildNodes, 'has no child nodes');
  node := node.firstChild;
  check(node <> nil, 'childNode does not exist');
  check(node.nodeName = 'abc:child', 'wrong nodeName');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType (II)');
  check(node.localName = 'child', 'wrong localName (II)');
  check(node.namespaceURI = 'http://abc.org', 'wrong namespaceURI (II)');
  attr := (node as IDOMElement).getAttributeNodeNS('http://ghi.org','attr');
  check(attr <> nil, 'attribute does not exist');
end;

procedure TTestDOM2Methods.basic_cloneNode_ElementNS_flat;
begin
  // scenario:
  // element1.element2.attribute
  // clone element1
  // check if element2 and attribute are not cloned too

  node := doc.createElementNs('http://abc.org', 'abc:child');
  elem := doc.createElementNs('http://def.org', 'def:test');
  elem.appendChild(node);
  doc.documentElement.appendChild(elem);

  // now clone the node flat
  node := elem.cloneNode(False);
  check(node <> nil, 'is nil');
  check(not MyIsSameNode(node, elem), 'target and source are the same');
  check(node.nodeName = 'def:test', 'wrong nodeName');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(node.namespaceURI='http://def.org','wrong namespaceURI');
  check(node.localName = 'test', 'wrong localName');
  check(not node.hasChildNodes, 'has child nodes');
end;

procedure TTestDOM2Methods.basic_cloneNode_Element_deep;
begin
  Name:='test'; //no unicode for now
  node := doc.createElement('child');
  elem := doc.createElement(Name);
  elem.appendChild(node);
  doc.documentElement.appendChild(elem);
  node := elem.cloneNode(True);
  check(not MyIsSameNode(node, elem), 'target and source are the same');
  check(node <> nil, 'node does not exist');
  check(node.nodeName = Name, 'wrong nodeName (I)');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType (I)');
  check(node.hasChildNodes, 'has no child nodes');
  node := node.firstChild;
  check(node <> nil, 'childNode does not exist');
  check(node.nodeName = 'child', 'wrong nodeName');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType (II)');
end;

procedure TTestDOM2Methods.basic_cloneNode_Element_flat;
begin
  Name:='test'; //no unicode for now
  node := doc.createElement('child');
  elem := doc.createElement(Name);
  elem.appendChild(node);
  doc.documentElement.appendChild(elem);
  node := elem.cloneNode(False);
  check(not MyIsSameNode(node, elem), 'target and source are the same');  
  check(node <> nil, 'is nil');
  check(node.nodeName = Name, 'wrong nodeName');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(not node.hasChildNodes, 'has child nodes');
  check(MyIsSameNode(node.ownerDocument,elem.ownerDocument), 'wrong ownerDocument');
end;

procedure TTestDom2Methods.basic_createAttribute;
begin
  attr := doc.createAttribute(Name);
  check(attr <> nil, 'is nil');
  check(attr.Name = Name, 'wrong name');
  check(attr.nodeName = Name, 'wrong nodeName');
  check(attr.namespaceURI = '', 'wrong namespaceURI');
  check(attr.localName = '', 'wrong localName');
  check(attr.prefix = '', 'wrong prefix');
  check(attr.Value = '', 'wrong value');
  check(attr.ownerDocument = doc, 'wrong ownerDocument');
end;

procedure TTestDom2Methods.basic_createAttributeNS;
begin
  // create an attribute with namespace declaration
  // and test if all properties are correctly set
  attr := doc.createAttributeNS(nsuri, fqname);
  check(attr <> nil, 'is nil');
  attr.Value := 'kamel';
  check(attr.Name = fqname, 'wrong name');
  check(attr.nodeName = fqname, 'wrong nodeName');
  check(attr.nodeType = ATTRIBUTE_NODE, 'wrong nodeType');
  check(attr.namespaceURI = nsuri, 'wrong namespaceURI');
  check(attr.prefix = prefix, 'wrong prefix');
  check(attr.localName = Name, 'wrong localName - expected: "'+Name+'" found: "'+attr.localName+'"');
  check(attr.specified, 'is not specified');
  check(attr.Value = 'kamel', 'wrong value');
end;

procedure TTestDom2Methods.basic_createCDATASection;
begin
  cdata := doc.createCDataSection(Data);
  check(cdata <> nil, 'is nil');
  check(cdata.Data = Data, 'wrong data');
  check(cdata.length = Length(Data), 'wrong length');
  check(cdata.nodeName = '#cdata-section', 'wrong nodeName');
  check(cdata.nodeValue = Data, 'wrong nodeValue');
  check(cdata.nodeType = CDATA_SECTION_NODE, 'wrong nodeType');
  cdata.appendData(Data);
  check(cdata.nodeValue = Data + Data, 'wrong nodeValue');
  check(cdata.subStringData(0,Length(Data)) = Data,
    'wrong subStringData - expected: "' + Data + '" found: "' +
    cdata.subStringData(0,Length(Data)) + '"');
  cdata.insertData(0,'0');
  check(cdata.nodeValue = '0' + Data + Data, 'wrong nodeValue');
  cdata.deleteData(0,1);
  check(cdata.nodeValue = Data + Data, 'wrong nodeValue');
  cdata.replaceData(Length(Data), Length(Data), '');
  check(cdata.nodeValue = Data, 'wrong nodeValue');
end;

procedure TTestDom2Methods.basic_createComment;
begin
  comment := doc.createComment(Data);
  check(comment <> nil, 'is nil');
  check(comment.Data = Data, 'wrong data');
  check(comment.length = Length(Data), 'wrong length');
  check(comment.nodeName = '#comment', 'wrong nodeName');
  check(comment.nodeValue = Data, 'wrong nodeValue');
  check(comment.nodeType = COMMENT_NODE, 'wrong nodeType');
end;

procedure TTestDom2Methods.basic_createDocumentFragment;
begin
  docfrag := doc.createDocumentFragment;
  check(docfrag <> nil, 'is nil');
  check(docfrag.nodeName = '#document-fragment', 'wrong nodeName');
  check(docfrag.nodeType = DOCUMENT_FRAGMENT_NODE, 'wrong nodeType');
end;

procedure TTestDom2Methods.basic_createElement;
begin
  elem := doc.createElement(Name);
  check(elem <> nil, 'is nil');
  check(elem.nodeName = Name, 'wrong nodeName');
  check(elem.tagName = Name, 'wrong tagName');
  check(elem.ownerDocument = doc, 'wrong ownerDocument');
  check(elem.namespaceURI = '', 'wrong namespaceURI');
  check(elem.prefix = '', 'wrong prefix');
  check(elem.localName = '', 'wrong localName');
end;

procedure TTestDom2Methods.basic_createElementNS;
begin
  // create an element with namespace declaration
  // and test if the properties are set correctly
  elem := doc.createElementNs(nsuri, fqname);
  check(elem <> nil, 'is nil');
  check(elem.nodeName = fqname, 'wrong nodeName');
  check(elem.tagName = fqname, 'wrong tagName');
  check(elem.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(elem.namespaceURI = nsuri, 'wrong namespaceURI');
  check(elem.prefix = prefix, 'wrong prefix');
  check(elem.localName = Name, 'wrong name');
  check(elem.attributes.length=0,'namespace decl attribute');
end;

procedure TTestDom2Methods.basic_createEntityReference;
begin
  entref := doc.createEntityReference(Name);
  check(entref <> nil, 'is nil');
  check(entref.nodeName = Name, 'wrong nodeName');
  check(entref.nodeType = ENTITY_REFERENCE_NODE, 'wrong nodeType');
end;

procedure TTestDom2Methods.basic_createProcessingInstruction;
begin
  pci := doc.createProcessingInstruction(Name, Data);
  check(pci <> nil, 'is nil');
  check(pci.target = Name, 'wrong target');
  check(pci.Data = Data, 'wrong data');
  check(pci.nodeName = Name, 'wrong nodeName');
  check(pci.nodeValue = Data, 'wrong nodeValue');
  check(pci.nodeType = PROCESSING_INSTRUCTION_NODE, 'wrong nodeType');
end;

procedure TTestDom2Methods.basic_createTextNode;
begin
  Text := doc.createTextNode(Data);
  check(Text <> nil, 'is nil');
  check(Text.Data = Data, 'wrong data');
  check(Text.length = Length(Data), 'wrong length');
  check(Text.nodeName = '#text', 'wrong nodeName');
  check(Text.nodeValue = Data, 'wrong nodeValue');
  check(Text.nodeType = TEXT_NODE, 'wrong nodeType');
  Text := Text.splitText(4);
  check(Text.Data = Copy(Data,5,Length(Data)-1),'wrong splitText - expected: "'+Copy(Data,5,Length(Data)-1)+'" found: "'+Text.Data+'"');
end;

procedure TTestDom2Methods.basic_docType;
begin
  // there's no DTD !
  check(doc.docType = nil, 'not nil');
  // load xml with dtd
  (doc as IDomPersist).loadxml(xmlstr2);
  check(doc.docType <> nil, 'there is a DTD but docType is nil');
  check(doc.docType.entities <> nil, 'there are entities but entities are nil');
  check(doc.docType.entities.length = 2, 'wrong entities length');
  check(doc.docType.notations <> nil, 'there are notations but notations are nil');
  check(doc.docType.notations.length = 1, 'wrong notations length');
end;

procedure TTestDom2Methods.basic_document;
begin
  check(doc <> nil, 'is nil');
  check(doc.nodeName = '#document', 'wrong nodeName');
  check(doc.nodeType = DOCUMENT_NODE, 'wrong nodeType');
  check(doc.ownerDocument = nil, 'ownerDocument not nil');
  check(doc.parentNode = nil, 'parentNode not nil');
  check(doc.namespaceURI = '', 'namespaceURI is not empty');
  check(doc.attributes = nil, 'attributes are not nil');
end;

procedure TTestDom2Methods.basic_documentElement;
begin
  elem := doc.documentElement;

  check(elem <> nil, 'is nil');
  check(elem.tagName = 'root', 'wrong tagName');
  check(elem.nodeName = 'root', 'wrong nodeName');
  check(elem.nodeType = ELEMENT_NODE, 'wrong nodeType');

  check(myIsSameNode(elem.parentNode,doc), 'wrong parentNode');
  check(myIsSameNode(elem.ownerDocument,doc), 'wrong ownerDocument');
  check(true);
end;

procedure TTestDom2Methods.basic_documentFragment;
const
  n = 10;
var
  i: integer;
  elem1: IDomElement;
begin
  check(doc.documentElement.childNodes.length = 0, 'wrong childNodes.length');
  docfrag := doc.createDocumentFragment;
  check(docfrag.nodeType = DOCUMENT_FRAGMENT_NODE,'wrong node type');
  check(docfrag.nodeName = '#document-fragment', 'wrong nodeName');
  for i := 0 to n - 1 do begin
    elem := doc.createElement(Name);
    elem.setAttribute(Name, Data + IntToStr(i));
    elem1 := doc.createElementNS(nsURI,fqname);
    elem.appendChild(elem1);
    docfrag.appendChild(elem);
  end;
  check(docfrag.childNodes.length = n, 'wrong childNodes.length');
  doc.documentElement.appendChild(docfrag);
  check(doc.documentElement.childNodes.length <> 0, 'childNodes.length = 0');
  check(doc.documentElement.childNodes[0].nodeName = Name,
    'wrong nodeName - expected: "' + Name +'" found: "' +
    doc.documentElement.childNodes[0].nodeName + '"');
  check(doc.documentElement.childNodes.length = n, 'wrong childNodes.length');
end;

procedure TTestDom2Methods.basic_domImplementation;
begin
  check(doc.domImplementation <> nil, 'is nil');
end;

procedure TTestDom2Methods.basic_firstChild;
const
  n = 10;
var
  i: integer;
begin
  for i := 0 to n - 1 do begin
    elem := doc.createElement(Name +IntToStr(i));
    doc.documentElement.appendChild(elem);
  end;
  node := doc.documentElement.firstChild;
  elem := doc.documentElement;
  check(elem.hasChildNodes, 'has no child nodes');
  check(node <> nil, 'first child is nil');
  check(node.nodeName = Name +'0', 'wrong nodeName');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(myIsSameNode(node.parentNode,elem), 'wrong parentNode');
  check(myIsSameNode(node.ownerDocument,doc), 'wrong ownerDocument');
end;

procedure TTestDom2Methods.basic_getAttributeNodeNS_setAttributeNodeNS;
begin
  elem := doc.createElement(Name);
  attr := doc.createAttributeNS(nsuri, fqname);
  elem.setAttributeNodeNS(attr);
  attr := elem.getAttributeNodeNS(nsuri, Name);
  check(attr <> nil, 'attribute is nil');
  check(attr.name = fqname, 'wrong name');
  check(attr.nodeName = fqname, 'wrong nodeName');
  check(attr.nodeType = ATTRIBUTE_NODE, 'wrong nodeType');
  check(MyIsSameNode(attr.parentNode,elem), 'wrong parentNode');
  check(attr.namespaceURI = nsuri, 'wrong namespaceURI');
  check(attr.prefix = prefix, 'wrong prefix');
  check(attr.localName = Name, 'wrong localName');
  check(MyIsSameNode(attr.ownerElement,elem), 'wrong ownerDocument');  
end;

procedure TTestDom2Methods.ext_getAttributeNodeNS;
begin
  elem := doc.createElement(Name);
  try
    attr := elem.getAttributeNodeNS(nsuri,Name);
    check(attr = nil, 'attribute is not nil');
  except
    fail('an exception was raised while getting a non existant attribute but nil should be returned');
  end;
end;

procedure TTestDom2Methods.ext_getAttributeNode_setAttributeNode;
begin
  elem := doc.createElement(Name);
  attr := doc.createAttribute('attr1');
  elem.setAttributeNode(attr);
  attr := doc.createAttribute('attr2');
  attr.Value := 'hund';
  elem.setAttributeNode(attr);
  attr := elem.getAttributeNode('attr1');
  check(attr <> nil, 'attribute is nil');
  attr := elem.getAttributeNode('attr2');
  check(attr.Value = 'hund', 'wrong value (I)');
  attr := doc.createAttribute('attr3');
  attr.Value := 'hase';
  elem.setAttributeNode(attr);
  attr := elem.getAttributeNode('attr3');
  check(attr.Value = 'hase', 'wrong value (II)');
  // try to get an attribute that does not exist
  attr := elem.getAttributeNode('item');
  check(attr = nil, 'getAttributeNode does not return nil');
end;

procedure TTestDom2Methods.basic_getAttributeNS_setAttributeNS;
begin
  elem := doc.createElement(Name);
  elem.setAttributeNS(nsuri, fqname, 'tiger');
  check(elem.getAttributeNS(nsuri, Name) = 'tiger', 'wrong value');
end;

procedure TTestDom2Methods.ext_getAttributeNS;
begin
  elem := doc.createElement(Name);
  try
    check(elem.getAttributeNS(nsuri, Name) = '', 'wrong value');
  except
    fail('getting the nodeValue of a non existant attribute raised an exception but should return an empty string');
  end;
end;

procedure TTestDom2Methods.basic_getAttribute_setAttribute;
begin
  elem := doc.createElement(Name);
  elem.setAttribute(Name, 'elephant');
  check(elem.getAttribute(Name) = 'elephant', 'wrong value');
end;

procedure TTestDom2Methods.ext_getAttribute;
begin
  elem := doc.createElement(Name);
  check(elem.getAttribute(Name) = '', 'getAttribute does not return an empty string but "'+elem.getAttribute(Name)+'"');
end;

procedure TTestDom2Methods.basic_getElementsByTagName;
const
  n = 10;
var
  i: integer;
begin
  for i := 0 to n - 1 do begin
    elem := doc.createElement(Name);
    doc.documentElement.appendChild(elem);
  end;
  // check document interface
  nodelist := doc.getElementsByTagName(Name);
  check(nodelist <> nil, 'getElementsByTagName returns nil');
  check(nodelist.length = n, 'wrong length');
  // check element interface
  nodelist := doc.documentElement.getElementsByTagName(Name);
  check(nodelist <> nil, 'getElementsByTagName returns nil');
  check(nodelist.length = n, 'wrong length');
  nodelist := doc.getElementsByTagName('*');
  check(nodelist.length = n + 1, 'wrong length');
end;

procedure TTestDom2Methods.basic_getElementsByTagNameNS;
const
  n = 10;
var
  i: integer;
begin
  for i := 0 to n - 1 do begin
    elem := doc.createElementNS(nsuri, fqname);
    doc.documentElement.appendChild(elem);
  end;
  // check document interface
  nodelist := doc.getElementsByTagNameNS(nsuri, Name);
  check(nodelist <> nil, 'getElementsByTagNameNS returns nil');
  check(nodelist.length = n, 'wrong length');
  // check element interface
  nodelist := doc.documentElement.getElementsByTagNameNS(nsuri, Name);
  check(nodelist <> nil, 'getElementsByTagNameNS returns nil');
  check(nodelist.length = n, 'wrong length');
end;

function TTestDom2Methods.getFqname: WideString;
begin
  if prefix = '' then result := Name
  else result := prefix + ':' + Name;
end;

procedure TTestDom2Methods.basic_hasAttribute_setAttributeNode;
begin
  elem := doc.createElement(Name);
  check(not elem.hasAttribute(Name), 'has attribute');
  attr := doc.createAttribute(Name);
  elem.setAttributeNode(attr);
  check(elem.hasAttribute(Name), 'has no attribute');
end;

procedure TTestDom2Methods.basic_hasAttributeNS_setAttributeNodeNS;
begin
  elem := doc.createElement(Name);
  check(not elem.hasAttributeNS(nsuri,Name), 'has attribute');
  attr := doc.createAttributeNS(nsuri, fqname);
  elem.setAttributeNodeNS(attr);
  check(elem.hasAttributeNS(nsuri, Name), 'has not attribute');
end;

procedure TTestDom2Methods.basic_hasChildNodes;
begin
  check(not doc.documentElement.hasChildNodes, 'has child nodes');
  elem := doc.createElement(Name);
  doc.documentElement.appendChild(elem);
  check(doc.documentElement.hasChildNodes, 'has no child nodes');
end;

procedure TTestDom2Methods.basic_importNode_Element_deep_flat;
var
  adoc: IDomDocument;
begin
  // create a second dom
  adoc := impl.createDocument('', '', nil);
  (adoc as IDomPersist).loadxml(xmlstr);
  elem := adoc.createElement(Name);
  node := adoc.createElement('second');
  elem.appendChild(node);
  adoc.documentElement.appendChild(elem);

  // import node not deep
  node := doc.importNode(adoc.documentElement.firstChild, False);
  check(node <> nil, 'importNode returned nil');
  check(not MyIsSameNode(node,adoc.documentElement.firstChild), 'target is the same as source'); ;
  check(node.ownerDocument = doc, 'wrong ownerDocument');
  check(node.parentNode = nil, 'parent node is not nil');
  check(not node.hasChildNodes, 'has child nodes');
  doc.documentElement.appendChild(node);

  // import node deep
  node := doc.importNode(adoc.documentElement.firstChild, True);
  check(node <> nil, 'importNode returned nil');
  check(not MyIsSameNode(node,adoc.documentElement.firstChild), 'target is the same as source'); ;
  check(node.ownerDocument = doc, 'wrong ownerDocument');
  check(node.parentNode = nil, 'parent node is not nil');
  check(node.hasChildNodes, 'has no child nodes');
  doc.documentElement.appendChild(node);

  // check result
  node := doc.documentElement.firstChild;
  check(node <> nil, 'first child is nil');
  check(node.nodeName = Name, 'wrong nodeName');
  node := doc.documentElement.lastChild;
  check(node <> nil, 'last child is nil');
  check(node.nodeName = Name, 'wrong nodeName');
  check(node.firstChild.nodeName = 'second', 'wrong nodeName');
end;

procedure TTestDom2Methods.basic_importNode_ElementNS_deep_flat;
var
  adoc: IDomDocument;
  node1: IDomNode;
begin
  // no unicode for now!
  nsuri:='http://abc';
  prefix:='ct';
  name:='hund';
  // create a second dom
  adoc := impl.createDocument('', '', nil);
  (adoc as IDomPersist).loadxml(xmlstr);
  elem := adoc.createElementNS(nsuri, prefix + ':' + Name);
  node := adoc.createElementNS(nsuri + 'f', prefix + ':' + 'second');
  elem.appendChild(node);
  adoc.documentElement.appendChild(elem);
  //debugDom(adoc,true);

  // import node not deep
  node1:= adoc.documentElement.firstChild;
  node := doc.importNode(node1, False);

  check(node <> nil, 'importNode returned nil');
  //check(node.ownerDocument = doc, 'wrong ownerDocument');
  check(node.parentNode = nil, 'parent node is not nil');
  check(node.namespaceURI = nsuri, 'namespace wrong');
  check(node.prefix = prefix, 'prefix wrong');
  check(not node.hasChildNodes, 'has child nodes');

  doc.documentElement.appendChild(node);

  // import node deep
  node := doc.importNode(adoc.documentElement.firstChild, True);
  check(node <> nil, 'importNode returned nil');
  //check(node.ownerDocument = doc, 'wrong ownerDocument');
  check(node.parentNode = nil, 'parent node is not nil');
  check(node.hasChildNodes, 'has no child nodes');
  check(node.firstChild.namespaceURI = nsuri + 'f', 'child: namespace wrong');
  check(node.firstChild.prefix = prefix, 'child: prefix wrong');
  check(node.firstChild.nodename = prefix + ':' + 'second', 'child: nodename wrong');
  // append this to dom
  doc.documentElement.appendChild(node);
  // check result
  node := doc.documentElement.firstChild;
  check(node <> nil, 'first child is nil');
  check(node.nodeName = prefix + ':' + Name, 'wrong nodeName');
  node := doc.documentElement.lastChild;
  check(node <> nil, 'last child is nil');
  check(node.nodeName = prefix + ':' + Name, 'wrong nodeName');
  check(node.firstChild.nodeName = prefix + ':' + 'second', 'wrong nodeName');

end;

procedure TTestDOM2Methods.basic_importNode_AttributeNode1;
var
  adoc: IDomDocument;
  attr1,attr2: IDOMAttr;
begin
  // create a second dom
  adoc := impl.createDocument('', '', nil);
  check((adoc as IDomPersist).loadxml(xmlstr), 'parse error');
  // append new attribute to documentElement of 2nd dom
  attr1 := adoc.createAttribute(Name);
  attr1.value:='blau';
  adoc.documentElement.setAttributeNode(attr1);
  // clone the attribute => 2nd new attribute
  // this is unneccessary, if you use libxmldom.pas
  attr2 := ((attr1 as IDOMNode).cloneNode(false)) as IDOMAttr;
  // import the attribute => 3rd new attribute
  // this is unneccessary, if you use msxml
  attr := (doc.importNode(attr2,false)) as IDOMAttr;
  // append the attribute to documentElement of 1st dom
  doc.documentElement.setAttributeNode(attr);
  attr:=nil;
  attr:=doc.documentElement.attributes[0] as IDomAttr;
  check(attr <> nil, 'attribute is nil');
  check(attr.name = Name,'wrong name of imported attribute');
  check(attr.value = 'blau','wrong value of imported attribute');
  check(not myIsSameNode(doc,adoc),'the two documents must not be the same');
  check(myIsSameNode(attr.ownerDocument,doc), 'wrong ownerDocument');
end;


procedure TTestDom2Methods.basic_insertBefore;
begin
  elem := doc.createElement(Name +'0');
  doc.documentElement.appendChild(elem);
  elem := doc.createElement(Name +'1');
  doc.documentElement.insertBefore(elem, doc.documentElement.firstChild);
  node := doc.documentElement.firstChild;
  check(node.nodeName = Name +'1', 'wrong nodeName');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(myIsSameNode(node.parentNode, doc.documentElement), 'wrong parentNode');
  check(node.ownerDocument = doc, 'wrong ownerDocument');
end;

procedure TTestDom2Methods.basic_isSupported;
begin
  check(doc.isSupported('Core', '2.0'), 'is false');
  check(doc.isSupported('XML', '2.0'), 'is false');
end;

procedure TTestDom2Methods.basic_lastChild;
const
  n = 10;
var
  i: integer;
begin
  for i := 0 to n - 1 do begin
    elem := doc.createElement(Name +IntToStr(i));
    doc.documentElement.appendChild(elem);
  end;
  node := doc.documentElement.lastChild;
  elem := doc.documentElement;
  check(elem.hasChildNodes, 'is false');
  check(node <> nil, 'is nil');
  check(node.nodeName = Name + IntToStr(n-1), 'wrong nodeName');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(myIsSameNode(node.parentNode,elem), 'wrong parentNode');
  check(myIsSameNode(node.ownerDocument,doc), 'wrong ownerDocument');
end;

procedure TTestDom2Methods.ext_namedNodeMap;
begin
  nnmap := doc.documentElement.attributes;
  check(nnmap <> nil, 'attributes are  nil');
  check(nnmap.length = 0, 'wrong length I)');
  // set a namedItem
  attr := doc.createAttribute(Name);
  attr.Value := Data;
  nnmap.setNamedItem(attr);
  check(nnmap.length = 1, 'wrong length (II)');
  check(myIsSameNode(nnmap.getNamedItem(Name), attr), 'wrong node');
  check(nnmap.getNamedItem(Name).nodeValue = Data, 'wrong nodeValue');
  // set a namedItem with the same name as before
  attr := doc.createAttribute(Name);
  attr.Value := Data;
  nnmap.setNamedItem(attr);
  check(nnmap.length = 1, 'wrong length (III)');
  // set a namedItem with a different name
  attr := doc.createAttribute('snake');
  attr.Value := 'python';
  nnmap.setNamedItem(attr);
  check(nnmap.length = 2, 'wrong length (IV)');
  check(myIsSameNode(nnmap.getNamedItem('snake'), attr), 'wrong node');
  check(nnmap.getNamedItem('snake').nodeValue = 'python', 'wrong nodeValue');
  nnmap.removeNamedItem(Name);
  check(nnmap.length = 1, 'wrong length (V)');
  check(nnmap.item[0].nodeName = 'snake', 'wrong nodeName');
  attr := nil;
  attr := nnmap.namedItem['snake'] as IDomAttr;
  check(attr.Value = 'python', 'wrong value');
  // try to get an item that does not exist
  node := nnmap.namedItem['purzelbaum'];
  check(node = nil, 'getting namedItem for an item that does not exist does not return nil');
end;

procedure TTestDom2Methods.ext_namedNodeMapNS;
begin
  nnmap := doc.documentElement.attributes;
  check(nnmap <> nil, 'is nil');
  check(nnmap.length = 0, 'wrong length (I)');
  // set a namedItem
  // 1. set the nsdecl
  attr := doc.createAttributeNS('http://www.w3.org/2000/xmlns/','xmlns:'+prefix);
  attr.value := nsuri;
  nnmap.setNamedItemNS(attr);
  // 2. set the item itself
  attr := doc.createAttributeNS(nsuri, fqname);
  attr.Value := Data;
  nnmap.setNamedItem(attr);
  check(nnmap.length = 2, 'wrong length (II)');
  node := nnmap.getNamedItemNS(nsuri, Name);
  check(myIsSameNode(node,attr), 'wrong node');
  check(nnmap.getNamedItemNS(nsuri, Name).nodeValue = Data, 'wrong nodeValue');
  // set a namedItem with the same name as before
  attr := doc.createAttributeNS(nsuri, fqname);
  attr.Value := Data;
  nnmap.setNamedItemNS(attr);
  check(nnmap.length = 2, 'wrong length (III)');
  // set a namedItem with a different name
  attr := doc.createAttributeNS(nsuri, prefix + ':snake');
  attr.Value := 'python';
  nnmap.setNamedItemNS(attr);
  check(nnmap.length = 3, 'wrong length (IV)');
  check(myIsSameNode(nnmap.getNamedItemNS(nsuri, 'snake'), attr), 'wrong node');
  check(nnmap.getNamedItemNS(nsuri, 'snake').nodeValue = 'python', 'wrong nodeValue');
  // remove the first named item - nsdecl should be kept
  nnmap.removeNamedItemNS(nsuri, Name);
  check(nnmap.length = 2, 'wrong length (V)');
  check(nnmap.getNamedItemNS(nsuri,'snake').localName = 'snake', 'wrong localName');
  attr := nil;
  attr := nnmap.getNamedItemNS(nsuri,'snake') as IDomAttr;
  check(attr.Value = 'python', 'wrong value');
  // remove secound named item
  nnmap.removeNamedItemNS(nsuri,'snake');
  check(nnmap.length = 1, 'wrong length (VI)');
  // remove the nsdecl
  nnmap.removeNamedItemNS(xmlns,prefix);
  check(nnmap.length = 0, 'wrong length (VII)');
  // try to get an item that does not exist
  try
    node := nnmap.getNamedItemNS('http://invalid.item.org','item');
    check(node = nil, 'getNamedItemNS does not return nil');
  except
    fail('getNamedItemNS raised an exception but should return nil');
  end;
end;

procedure TTestDom2Methods.ext_nextSibling_10times;
const
  n = 10;
var
  i: integer;
begin
  for i := 0 to n - 1 do begin
    elem := doc.createElement(Name +IntToStr(i));
    doc.documentElement.appendChild(elem);
  end;
  elem := doc.documentElement;
  node := elem.firstChild;
  for i := 1 to n - 1 do begin
    node := node.nextSibling;
    check(node.nodeName = Name +IntToStr(i), 'wrong nodeName');
  end;
end;

procedure TTestDom2Methods.unknown_normalize;
const
  n = 10;
var
  i:   integer;
  tmp: WideString;
begin
  // normalize summarizes text-nodes
  for i := 0 to n - 1 do begin
    Text := doc.createTextNode(Data + IntToStr(i));
    doc.documentElement.appendChild(Text);
  end;
  //check(doc.documentElement.firstChild.nodeValue = data+'0', 'wrong nodeValue');
  for i := 0 to doc.documentElement.childNodes.length - 1 do begin
    node := doc.documentElement.childNodes[i];
    if node.nodeType = TEXT_NODE then tmp := tmp + node.nodeValue;
  end;
  doc.documentElement.normalize;
  for i := 0 to doc.documentElement.childNodes.length - 1 do begin
    node := doc.documentElement.childNodes[i];
    if node.nodeType = TEXT_NODE then begin
      check(node.nodeValue = tmp, 'wrong nodeValue');
      break;
    end;
  end;
  {
  // normalize sorts element-nodes before text-nodes ???
  elem := doc.createElement(name);
  doc.documentElement.appendChild(elem);
  check(doc.documentElement.firstChild.nodeType = TEXT_NODE, 'wrong nodeType');
  doc.documentElement.normalize;
  check(doc.documentElement.firstChild.nodeType = ELEMENT_NODE, 'wrong nodeType - element-node should be first');
  }
end;

procedure TTestDom2Methods.basic_ownerElement;
begin
  attr := doc.createAttribute(Name);
  elem := doc.createElement(Name);
  elem.setAttributeNode(attr);
  doc.documentElement.appendChild(elem);
  check(myIsSameNode(attr.ownerElement, elem), 'wrong ownerElement');
end;

procedure TTestDom2Methods.ext_previousSibling_10times;
const
  n = 10;
var
  i: integer;
begin
  for i := 0 to n - 1 do begin
    elem := doc.createElement(Name +IntToStr(i));
    doc.documentElement.appendChild(elem);
  end;
  elem := doc.documentElement;
  node := elem.lastChild;
  for i := n - 2 downto 0 do begin
    node := node.previousSibling;
    check(node.nodeName = Name +IntToStr(i), 'wrong nodeName');
  end;
end;

procedure TTestDom2Methods.basic_removeAttribute;
begin
  elem := doc.createElement(Name);
  attr := doc.createAttribute(Name);
  elem.setAttributeNode(attr);
  elem.removeAttribute(Name);
  check(not elem.hasAttribute(Name), 'attribute still exists');
end;

procedure TTestDom2Methods.basic_removeAttributeNode;
begin
  elem := doc.createElement(Name);
  attr := doc.createAttribute(Name);
  elem.setAttributeNode(attr);
  elem.removeAttributeNode(attr);
  check(not elem.hasAttribute(Name), 'attribute still exists');
end;

procedure TTestDom2Methods.basic_removeAttributeNS;
begin
  elem := doc.createElement(Name);
  attr := doc.createAttributeNS(nsuri, fqname);
  elem.setAttributeNodeNS(attr);
  elem.removeAttributeNS(nsuri, Name);
  check(not elem.hasAttributeNS(nsuri, Name), 'is true');
end;

procedure TTestDom2Methods.basic_removeChild;
begin
  elem := doc.createElement(Name);
  doc.documentElement.appendChild(elem);
  doc.documentElement.removeChild(elem);
  check(not doc.documentElement.hasChildNodes, 'has child nodes');
end;

procedure TTestDom2Methods.basic_replaceChild;
begin
  elem := doc.createElement(Name +'0');
  doc.documentElement.appendChild(elem);
  elem := doc.createElement(Name +'1');
  doc.documentElement.replaceChild(elem, doc.documentElement.firstChild);
  check(doc.documentElement.hasChildNodes, 'has no child nodes');
  check(doc.documentElement.childNodes.length = 1, 'wrong count of childNodes');
  check(doc.documentElement.firstChild.nodeName = Name +'1', 'wrong nodeName');
end;

procedure TTestDom2Methods.ext_element_setNodeValue;
var
  tmp: string;
begin
  // setting the nodeValue of an element node should have no effect (w3c.org)
  elem := doc.createElement(Name);
  doc.documentElement.appendChild(elem);
  tmp := (doc as IDomPersist).xml;
  try
    elem.nodeValue := Data;
  except
    fail('setting the nodeValue of an element raised an exception but should have no effect');
  end;
  check((doc as IDomPersist).xml = tmp, 'Setting the nodeValue of an element node has an effect.');
end;

procedure TTestDom2Methods.ext_document_setNodeValue;
var
  tmp: string;
begin
  // setting the nodeValue of an document node should have no effect (w3c.org)
  tmp := (doc as IDomPersist).xml;
  try
    doc.nodeValue := Data;
  except
    fail('setting the nodeValue of a document raised an exception but schould have no effect');
  end;
  check((doc as IDomPersist).xml = tmp, 'Setting the nodeValue of a document node has an effect.');
end;

procedure TTestDom2Methods.ext_nsdecl;
const
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
begin
  // test if the namespace declaration is an attribute of the element
  // load a simple xml structure with a namespace declaration at the documentElement
  (doc as IDomPersist).loadxml(xmlstr3);
  nnmap := doc.documentElement.attributes;
  // test if parsed namespace attributes appear in attributes.length
  {$ifdef strict}
  check(nnmap.length = 5, 'wrong length (I) - maybe the namespace declaration is not shown');
  {$else}
  check(nnmap.length = 4, 'wrong length (I) - maybe the namespace declaration is shown');
  {$endif}
  // test standard attribute
  attr := nnmap.namedItem['id'] as IDOMAttr;
  // test standard properties of the attribute
  check(attr.Name = 'id', 'normal attr: wrong name');
  check(attr.Value = 'xcl.customers.list', 'normal attr: wrong value');
  // test namespace attribute
  attr := nnmap.getNamedItemNS('http://www.w3.org/2000/xmlns/','xob') as IDOMAttr;
  // test standard properties of the attribute
  // if not found, this mean xmlns declarations are not shown in attributes
  // but this is not an error per definition
  if (not Assigned(attr)) then exit;
  // if we found one, make sure that its correct
  check(attr <> nil, 'namespace declaration is shown in attributes');
  check(attr.Name = 'xmlns:xob', 'xmlns attr: wrong name');
  check(attr.Value = 'http://xmlns.4commerce.de/xob', 'xmlns attr: wrong value');
  check(attr.prefix = 'xmlns', 'xmlns attr: wrong prefix');
  check(attr.localName = 'xob', 'xmlns attr: wrong localName');
  //debugDom(doc,true);
  {
  Note: In the DOM, all namespace declaration attributes are BY DEFINITION bound
  to the namespace URI: "http://www.w3.org/2000/xmlns/". These are the attributes
  whose namespace prefix or qualified name is "xmlns". Although, at the time of
  writing, this is not part of the XML Namespaces specification [XML Namespaces],
  it is planned to be incorporated in a future revision. (w3c.org)
  }
  {check(attr.namespaceURI = 'http://www.w3.org/2000/xmlns/',
    'xmlns attr: wrong namespaceURI - expected: "http://www.w3.org/2000/xmlns/" found: "' +
    attr.namespaceURI + '"');}
end;

procedure TTestDOM2Methods.ext_unicode_TextNodeValue;
  // this test appends a text node with greek and coptic unicode characters
var
  ws: widestring;
  ok: boolean;
begin
  ws := getUnicodeStr;
  text := doc.createTextNode(ws);
  ws := '';
  doc.documentElement.appendChild(text);
  ws := doc.documentElement.firstChild.nodeValue;
  ok := ws=getUnicodeStr;
  check(ok, 'incorrect unicode handling');
end;

procedure TTestDOM2Methods.ext_unicode_NodeName;
  // this test appends a node with a name containing unicode characters
var
  ws: WideString;
  ok: boolean;
begin
  ws := getUnicodeStr(1);
  node := doc.createElement(ws);
  doc.documentElement.appendChild(node);
  ws := '';
  ws := doc.documentElement.firstChild.nodeName;
  ok := ws=getUnicodeStr(1);
  check(ok, 'incorrect unicode handling');
end;

procedure TTestDOM2Methods.ext_checkIgnoreDocumentProcessInstruction;
const
  header='<?xml version="1.0" ?>';
var
  temp: string;
begin
  doc := impl.createDocument('','',nil);
  check(doc.documentElement = nil,'docelement is not nil');
  check((doc as IDomPersist).xml='','document isn''t empty');
  // this PI is to be ignored, cause the document header PI ist only created
  // by output and therefor you have to set the output options
  pci := doc.createProcessingInstruction('xml','version="1.0" encoding="iso-8859-1"');
  doc.appendChild(pci);
  elem := doc.createElement('root');
  doc.appendChild(elem);
  check(doc.documentElement.nodeName = 'root', 'wrong documentElement');
  temp:=((doc as IDOMPersist).xml);
  temp:=GetHeader(temp);
  check(StringReplace(temp, ' ', '', [rfReplaceAll]) = StringReplace(header, ' ', '', [rfReplaceAll]), 'wrong document header (PI)')
end;

procedure TTestDom2Methods.ext_appendChild_10times;
const
  n = 10;
var
  i: integer;
begin
  check(doc.documentElement.childNodes.length = 0, 'wrong length');
  for i := 0 to n - 1 do begin
    elem := doc.createElement(Name +IntToStr(i));
    doc.documentElement.appendChild(elem);
  end;
  check(doc.documentElement.childNodes.length = n, 'wrong length');
  for i := 0 to doc.documentElement.childNodes.length - 1 do begin
    node := doc.documentElement.childNodes.item[i];
    check(node <> nil, 'is nil');
    check(node.nodeName = Name +IntToStr(i), 'wrong nodeName');
    check(node.nodeType = ELEMENT_NODE, 'wrong noodeType');
    check(myIsSameNode(node.parentNode, doc.documentElement), 'wrong parentNode');
    node := doc.documentElement.childNodes[i];
    check(node <> nil, 'is nil');
    check(node.nodeName = Name +IntToStr(i), 'wrong nodeName');
    check(node.nodeType = ELEMENT_NODE, 'wrong noodeType');
    check(myIsSameNode(node.parentNode, doc.documentElement), 'wrong parentNode');
  end;
end;

procedure TTestDOM2Methods.basic_nsdecl;
begin
  attr := doc.createAttributeNS('http://www.w3.org/2000/xmlns/','xmlns:frieda');
  attr.nodeValue := 'http://frieda.org';
  doc.documentElement.setAttributeNodeNs(attr);
  check(doc.documentElement.attributes.length = 1, 'wrong length');
  check(doc.documentElement.attributes[0].nodeName = 'xmlns:frieda', 'wrong nodeName');
  check(doc.documentElement.attributes[0].nodeValue = 'http://frieda.org', 'wrong nodeValue');
  check(doc.documentElement.attributes[0].prefix = 'xmlns', 'wrong prefix');
  check(doc.documentElement.attributes[0].localName = 'frieda', 'wrong localName');
  check(doc.documentElement.attributes[0].namespaceURI = 'http://www.w3.org/2000/xmlns/', 'wrong namespaceURI');
end;

procedure TTestDOM2Methods.ext_getElementsByTagNameNS_10times;
const
  n = 10;
  m = 5;
var
  i,j: integer;
  s: string;
begin
  for i := 0 to n-1 do begin
    for j := 0 to m-1 do begin
      elem := doc.createElementNS(Format('http://www.%dcommerce.de/test',[i]),Format('test%d:elem',[i]));
      elem.setAttribute('id',IntToStr(j));
      doc.documentElement.appendChild(elem);
    end;
  end;
  for i := 0 to n-1 do begin
    nodelist := doc.getElementsByTagNameNS(Format('http://www.%dcommerce.de/test',[i]),'elem');
    check(nodelist.length = m, 'wrong length');
    for j := 0 to m-1 do begin
      s := (nodelist[j] as IDOMElement).getAttribute('id');
      check(s=IntToStr(j),'wrong id');
    end;
  end;
end;

procedure TTestDOM2Methods.basic_hasAttributes_setAttribute;
begin
  elem := doc.createElement(Name);
  check(not elem.hasAttributes, 'has attributes');
  elem.setAttribute(Name,Data);
  check(elem.hasAttributes, 'has no attributes');
end;

procedure TTestDOM2Methods.ext_setAttributeNS;
//var err: boolean;
begin
  elem := doc.createElementNS(nsuri,fqname);
    // there's a namespace declaration
    // even though it's an attribute, it must not be shown
    check(not elem.hasAttributes, 'namespace declaration attributes must not be shown here');
    check(elem.attributes.length = 0, 'wrong length (I)');

  // make elem visible to ().xml
  doc.documentElement.appendChild(elem);

  elem.setAttributeNS(xmlns,'xmlns:abc','http://abc.org');
    // namespace declaration was set
    check(elem.attributes.length = 1, 'wrong length (Ia)');

  //I don't know, whether this check is OK
  //check(elem.getAttributeNS(xmlns,'abc') = 'http://abc.org', 'wrong value - found: "'+elem.getAttributeNS(xmlns,'abc')+'"');

  elem.setAttributeNS('http://abc.org','abc:wauwau',Data);
    // an attribute and a namespace declaration has been appended
    check(elem.attributes.length = 2, 'wrong length (II)');

  elem.setAttributeNS('http://abc.org','abc:mietze',Data);
    check(elem.attributes.length = 3, 'wrong length (III)');

  elem.setAttributeNS(nsuri,prefix+':bobo',Data);
    check(elem.attributes.length = 4, 'wrong length (IV)');

  elem.setAttributeNS('',Name,Data);
    // i wish to set an attribute that is not bount to a namespace
    check(elem.attributes.length = 5, 'wrong length (V)');

  elem.setAttributeNS(xmlns,'xmlns:def','http://abc.org');
    check(elem.attributes.length = 6, 'wrong length (VI)');

  elem.setAttributeNS('http://abc.org','def:zebra',Data);
    // the namespace uri was previously bound to the prefix 'abc'
    // is it an error ?
    check(elem.attributes.length = 7, 'wrong length (VII)');

  // removed to TestDOMExceptions:
  // setting an attribute with a prefix
  // that was previously bound to another namespace uri
end;

procedure TTestDOM2Methods.ext_appendChild_removeChild;
var a,b,c,d,e: IDOMElement;
begin
  a := doc.createElement('el_A');
  b := doc.createElement('el_B');
  c := doc.createElement('el_C');
  d := doc.createElement('el_D');
  e := doc.createElement('el_E');
    check(doc.documentElement.childNodes.length = 0, 'wrong length (I)');

  // append a child to an empty list
  doc.documentElement.appendChild(a);
    check(doc.documentElement.childNodes.length = 1, 'wrong length (II)');

  // remove child that is first and last
  doc.documentElement.removeChild(a);
    check(doc.documentElement.childNodes.length = 0, 'wrong length (III)');

  doc.documentElement.appendChild(b);
    check(doc.documentElement.childNodes.length = 1, 'wrong length (IV)');

  // append child to a filled list
  doc.documentElement.appendChild(c);
    check(doc.documentElement.childNodes.length = 2, 'wrong length (V)');

  // remove child that is last but not first
  doc.documentElement.removeChild(c);
    check(doc.documentElement.childNodes.length = 1, 'wrong length (VI)');

  doc.documentElement.appendChild(d);
    check(doc.documentElement.childNodes.length = 2, 'wrong length (VII)');

  doc.documentElement.appendChild(e);
    check(doc.documentElement.childNodes.length = 3, 'wrong length (VIII)');

  // remove child that is in the middle of the list
  doc.documentElement.removeChild(d);
    check(doc.documentElement.childNodes.length = 2, 'wrong length (IX)');

  // remove child that is first but not last
  doc.documentElement.removeChild(b);
    check(doc.documentElement.childNodes.length = 1, 'wrong length (X)');

end;

procedure TTestDOM2Methods.ext_setAttributeNS_removeAttributeNS;
begin
  elem := doc.createElementNS('','test');
    check(not elem.hasAttributes, 'has attributes (I)');

  // make elem visible to ().xml
  doc.documentElement.appendChild(elem);

  elem.setAttributeNS('http://www.w3.org/2000/xmlns/','xmlns:abc','http://abc.org');
    // append a namespace declaration explicitly
    check(elem.hasAttributes, 'has no attributes');
    check(elem.attributes.length = 1, 'wrong length (0)');

  elem.setAttributeNS('http://abc.org','abc:zebra',Data);
    // append an attribute
    check(elem.nodeName = 'test', 'wrong nodeName');
    check(elem.hasAttributes, 'has no attributes (I)');
    check(elem.attributes.length = 2, 'wrong length (I)');
    check(elem.hasAttributeNS('http://abc.org','zebra'), 'has no attribute named "abc:zebra"');

  elem.removeAttributeNS('http://abc.org','zebra');
    // remove an attribute that is the first and last
    check(elem.hasAttributes, 'has no attributes (II)');
    check(elem.attributes.length = 1, 'wrong length (II)');

  // try to remove an attribute that does not exist
  try
    elem.removeAttributeNS('http://invalid.item.org','item');
  except
    fail('removeAttributeNS raises an exception but this action should have no effect');
  end;

  elem.setAttributeNS('http://abc.org','abc:zebra',Data);
  elem.setAttributeNS('http://abc.org','abc:okapi',Data);
  elem.setAttributeNS('http://abc.org','abc:apple',Data);
    check(elem.attributes.length = 4, 'wrong length (IIIa)');

  elem.removeAttributeNS('http://abc.org','apple');
    // remove an attribute that is the last but not first
    check(elem.attributes.length = 3, 'wrong length (IIIb)');

  elem.setAttributeNS('http://def.org','def:spider',Data);
    check(elem.attributes.length = 4, 'wrong length (IV)');

  elem.removeAttributeNS('http://abc.org','zebra');
    // remove an attribute that is the first but not last
    check(elem.attributes.length = 3, 'wrong length (V)');

  elem.setAttributeNS('http://abc.org','abc:zebra',Data);
  elem.setAttributeNS('http://ghi.org','ghi:bear',Data);
    check(elem.attributes.length = 5, 'wrong length (VI)');

  elem.removeAttributeNS('http://abc.org','zebra');
    // remove an attribute that is in the middle
    check(elem.attributes.length = 4, 'wrong legth (VII)');
end;

procedure TTestDOM2Methods.ext_createElementNS_defaultNS;
var
  s1: string;
begin
  // xmlns:abc="..." declares a namespace
  // xmlns="..." declares the default namespace
  // the default namespace is not copied to each child
  check((doc as IDOMPersist).loadxml(xmldecl+'<root xmlns="http://test.site" />'), 'parse error');
  check(doc.documentElement.namespaceURI = 'http://test.site', 'namespaceURI not correct');


  elem := doc.createElementNS('http://site.site','def');
  doc.documentElement.appendChild(elem);
  // compare that namespace are not equal
  check(elem.namespaceURI = 'http://site.site', 'elements namestpaceURI is not correct');

  elem := doc.createElementNS('','def');
  //elem := doc.createElement('def');
  doc.documentElement.appendChild(elem);
  // compare that namespace are not equal
  check(elem.namespaceURI = '', 'elements namespaceURI is not empty');

  s1 := (doc as IDomPersist).xml;

  check((doc0 as IDomPersist).loadxml(s1), 'document could not be parsed');
  //debugDom(doc);
  //debugDom(doc0);
  // now check that they are equal;
  Check (doc.documentElement.namespaceURI = doc0.documentElement.namespaceURI, 'default NS differs');
  Check (doc.documentElement.attributes.length = doc0.documentElement.attributes.length, 'roots attribute count  differs');
  Check (doc.documentElement.childNodes.length = doc0.documentElement.childNodes.length, 'roots node count  differs');
  Check (doc.documentElement.childNodes.Item[0].namespaceURI = doc0.documentElement.childNodes.Item[0].namespaceURI, 'namespaceURI of Element 0 differs');
  Check (doc.documentElement.childNodes.Item[1].namespaceURI = doc0.documentElement.childNodes.Item[1].namespaceURI, 'namespaceURI of Element 1 differs');

end;

procedure TTestDOM2Methods.ext_docType;
const
  xmlstr2 = xmldecl +
          '<!DOCTYPE root [' + '<!ELEMENT root (test*)>' +
          '<!ELEMENT test (#PCDATA)>' +
          '<!ATTLIST test name CDATA #IMPLIED>' +
          '<!ENTITY ct "4 commerce technologies">' +
          '<!NOTATION gif SYSTEM "gifview.exe">' +
          '<!ENTITY picture1 SYSTEM "picture1.gif" NDATA gif>' + ']>' +
          '<root />';
var
  //i: integer;
  entities:  IDomNamedNodeMap;
  notations: IDomNamedNodeMap;
  node:     IDomNode;
  ent:      IDomEntity;
  notation: IDomNotation;
begin
  // there's no DTD !
  check(doc.docType = nil, 'not nil');

  // load xml with dtd
  (doc as IDomPersist).loadxml(xmlstr2);
  check(doc.docType <> nil, 'there is a DTD but docType is nil');
  check(doc.docType.entities <> nil, 'there are entities but entities are nil');
  check(doc.docType.entities.length = 2, 'wrong entities length');

  // get the entities
  entities:=doc.docType.entities;

  // get the entity 'picture1'
  node:=entities.namedItem['picture1'];
  ent:=node as IDomEntity;
  check(ent.nodeName='picture1');
  check(ent.notationName='gif','wrong notationName');
  check(ent.systemId='picture1.gif','wrong systemId');

  // get the notations
  notations:=doc.docType.notations;
  check(notations<>nil,'there are notations but the list of notations is nil');
  check(notations.length = 1, 'wrong notations length');

  // get the notation 'gif'
  node:=notations.namedItem['gif'];
  check(node<>nil,'notation gif not found');
  notation:=node as IDomNotation;
  check(notation.systemId='gifview.exe','wrong systemId of notation');
  check(notation.nodeName='gif','wrong notation.nodeName');
end;

procedure TTestDOM2Methods.ext_getElementsByTagName;
var
  i: integer;
begin
  // build scenario
  elem := doc.createElement(Name);
  doc.documentElement.appendChild(elem);
  for i := 0 to 9 do begin
    elem := doc.createElement(Name);
    doc.documentElement.firstChild.appendChild(elem);
    elem := doc.createElement('bear');
    doc.documentElement.firstChild.appendChild(elem);
  end;

  // test
  nodelist := doc.documentElement.getElementsByTagName(Name);
  check(nodelist <> nil, 'getElementsByTagName returned nil (I)');
  check(nodelist.length = 11, 'wrong length (I)'+IntToStr(nodelist.length));

  nodelist := doc.documentElement.getElementsByTagName('*');
  check(nodelist <> nil, 'getElementsByTagName returned nil (II)');
  check(nodelist.length = 21, 'wrong length (II)'+IntToStr(nodelist.length));

  nodelist := (doc.documentElement.firstChild as IDOMElement).getElementsByTagName(Name);
  check(nodelist <> nil, 'getElementsByTagName returned nil (III)');
  check(nodelist.length = 10, 'wrong length (II)'+IntToStr(nodelist.length));

  nodelist := (doc.documentElement.firstChild as IDOMElement).getElementsByTagName('*');
  check(nodelist <> nil, 'getElementsByTagName returned nil (II)');
  check(nodelist.length = 20, 'wrong length (II)'+IntToStr(nodelist.length));
end;

procedure TTestDOM2Methods.ext_getElementsByTagNameNS;
const
  n = 10;
var
  i,j: integer;
  elem1: IDOMElement;
  //s: string;
begin
  // build scenario
  for i := 0 to n - 1 do begin
    elem := doc.createElementNS(nsuri, fqname);
    doc.documentElement.appendChild(elem);
    for j := 0 to n - 1 do begin
      elem1 := doc.createElementNS(nsuri,'abc:tag');
      elem.appendChild(elem1);
      elem1 := doc.createElementNS('http://orf.org','orf:tag');
      elem.appendChild(elem1);
      elem1 := doc.createElementNS('http://orf.org','orf:'+Name);
      elem.appendChild(elem1);
    end;
  end;
  // check element interface
  nodelist := doc.documentElement.getElementsByTagNameNS(nsuri, Name);
  check(nodelist <> nil, 'getElementsByTagNameNS returns nil');
  check(nodelist.length = n, 'wrong length (I)'+IntToStr(nodelist.length));
  nodelist := doc.documentElement.getElementsByTagNameNS(nsuri, '*');
  check(nodelist <> nil, 'getElementsByTagNameNS returns nil');
  {s := '';
  for i := 0 to nodelist.length-1 do begin
    s := s + nodelist[i].nodeName + ' - ' + nodelist[i].namespaceURI + CRLF;
  end;
  showMessage(s);}
  check(nodelist.length = n+n*n, 'wrong length (II)'+IntToStr(nodelist.length));
  nodelist := doc.documentElement.getElementsByTagNameNS('*', Name);
  check(nodelist <> nil, 'getElementsByTagNameNS returns nil');
  check(nodelist.length = n+n*n, 'wrong length (III)'+IntToStr(nodelist.length));
  nodelist := doc.documentElement.getElementsByTagNameNS('*', 'tag');
  check(nodelist <> nil, 'getElementsByTagNameNS returns nil');
  check(nodelist.length = n*n*2, 'wrong length IV)'+IntToStr(nodelist.length));
  nodelist := doc.documentElement.getElementsByTagNameNS('http://orf.org', '*');
  check(nodelist <> nil, 'getElementsByTagNameNS returns nil');
  check(nodelist.length = n*n*2, 'wrong length V'+IntToStr(nodelist.length));
end;

procedure TTestDOM2Methods.ext_setAttributeNodeNs_NsDecl;
begin
  elem := doc.createElementNS('','test');
  check(not elem.hasAttributes, 'has attributes');
  attr := doc.createAttributeNS(xmlns,'xmlns:abc');
  attr.value := 'http://abc.org';
  elem.setAttributeNodeNS(attr);
  check(elem.hasAttributes, 'has no attributes');
  attr := elem.getAttributeNodeNS(xmlns,'abc');
  check(attr<>nil,'namespace-attribute is not shown');
end;

procedure TTestDOM2Methods.basic_importNode_AttributeNodeNS1;
var
  adoc: IDomDocument;
  attr1,attr2: IDOMAttr;
begin
  // create a second dom
  adoc := impl.createDocument('', '', nil);
  check((adoc as IDomPersist).loadxml(xmlstr), 'parse error');
  // append new attribute to documentElement of 2nd dom
  attr1 := adoc.createAttributeNs(nsuri, fqname);
  attr1.value:='grün';
  check(attr1.name=fqname,'wrong name of original attribute');
  adoc.documentElement.setAttributeNodeNs(attr1);
  attr1:=nil;
  attr1:=adoc.documentElement.attributes[0] as IDomAttr;
  check(attr1.name=fqname,'wrong name of original attribute');
  // clone the attribute => 2nd new attribute
  // this is unneccessary, if you use libxmldom.pas
  attr2 := ((attr1 as IDOMNode).cloneNode(false)) as IDOMAttr;
  check(attr2.name=fqname,'wrong name of original attribute');
  // import the attribute => 3rd new attribute
  // this is unneccessary, if you use msxml
  attr := (doc.importNode(attr2,false)) as IDOMAttr;
  check(attr.name=fqname,'wrong name of imported attribute');
  // append the attribute to documentElement of 1st dom
  doc.documentElement.setAttributeNodeNs(attr);
  attr:=nil;
  attr:=doc.documentElement.attributes[0] as IDomAttr;
  check(attr <> nil, 'attribute is nil');
  check(attr.name=fqname,'wrong name of imported attribute');
  check(attr.value='grün','wrong value of imported attribute');
  check(not myIsSameNode(doc,adoc),'the two documents must not be the same');
  check(myIsSameNode(attr.ownerDocument,doc), 'wrong ownerDocument');
end;

procedure TTestDOM2Methods.ext_appendAttributeNodeNS_removeAttributeNode;
begin
  elem := doc.createElementNS(nsuri,fqname);
  attr := doc.createAttributeNS(nsuri,fqname);
  check(not elem.hasAttributes, 'element has attributes');
  elem.setAttributeNodeNS(attr);
  check(elem.hasAttributes, 'element has no attributes');

  // remove an attribute that is the first and the last
  elem.removeAttributeNode(attr);
  check(not elem.hasAttributes, 'element has attributes, perhaps attribute was not removed');
  elem.setAttributeNodeNS(attr);
  check(elem.attributes.length = 1, 'wrong length (I)');
  attr := doc.createAttributeNS('http://abc.org','abc:test');
  elem.setAttributeNodeNS(attr);
  check(elem.attributes.length = 2, 'wrong length (II)');
  attr := doc.createAttributeNS('http://orf.org','orf:test');
  elem.setAttributeNodeNS(attr);
  check(elem.attributes.length = 3, 'wrong length (III)');
  attr := elem.getAttributeNodeNS(nsuri,Name);
  check(attr <> nil, 'attribute is nil/not found');

  // remove an attribute that is the first but not last
  elem.removeAttributeNode(attr);
  check(elem.attributes.length = 2, 'wrong length (IV)');
  elem.setAttributeNodeNS(attr);
  check(elem.attributes.length = 3, 'wrong length (V)');

  // remove an attribute that is the last but not first
  elem.removeAttributeNode(attr);
  check(elem.attributes.length = 2, 'wrong length (VI)');
  elem.setAttributeNodeNS(attr);
  check(elem.attributes.length = 3, 'wrong length (VII)');
  attr := elem.getAttributeNodeNS('http://orf.org','test');

  // remove an attribute that is in the middle
  elem.removeAttributeNode(attr);
  check(elem.attributes.length = 2, 'wrong length (VIII)');
end;

procedure TTestDOM2Methods.ext_removeAttributeNs;
const
  xml = xmldecl+
        '<test xmlns:eva="http://www.4commerce.de/eva"  eva:attrib="value1" />';
var
  doc:  IDomDocument;
  ok:   boolean;
  attr: IDomAttr;
begin
  doc := impl.createDocument('','',nil);
  ok := (doc as IDomPersist).loadxml(xml);
  check(ok,'parse error');
  elem := doc.documentElement;
  check(elem.nodeName = 'test');
{ TODO : correct this if libxml behaves right; length = 2, namespace was parsed }
  check(elem.attributes.length = 1,'wrong length');
  attr:=elem.attributes[0] as IDomAttr;
  check(attr <> nil,'attribute is nil');
  check(attr.name = 'eva:attrib');
  check(elem.hasAttributeNS('http://www.4commerce.de/eva','attrib'),'attribute not found');
  // remove a parsed attribute that is the first and last
  elem.removeAttributeNS('http://www.4commerce.de/eva','attrib');
  check(not elem.hasAttributes, 'still has attributes');
  check(elem.attributes.length = 0, 'wrong length II');
  doc:=nil;
  attr:=nil;
end;

procedure TTestDOM2Methods.ext_docType_entities;
const
  xmlstr2 = xmldecl +
          '<!DOCTYPE root [' +
          '<!ELEMENT root (#PCDATA)>' +
          '<!ENTITY ct "4 commerce technologies">' +
          '<!NOTATION gif SYSTEM "gifview.exe">' +
          '<!ENTITY picture1 SYSTEM "picture1.gif" NDATA gif>' + ']>' +
          '<root>&ct;</root>';
var
  entities: IDomNamedNodeMap;
  node:     IDomNode;
  ent:      IDomEntity;
  sl:       TStrings;
  i:        integer;
begin
  // there's no DTD !
  check(doc.docType = nil, 'not nil');

  // load xml with dtd
  (doc as IDomPersist).loadxml(xmlstr2);
    check(doc.docType <> nil, 'there is a DTD but docType is nil');
    check(doc.docType.entities <> nil, 'there are entities but entities are nil');
    check(doc.docType.entities.length = 2, 'wrong entities length');

  // get the entities
  entities := doc.docType.entities;

  // get the entity 'picture1'
  node := entities.namedItem['picture1'];
  ent := node as IDomEntity;
    check(ent.nodeName = 'picture1');
    check(ent.notationName = 'gif','wrong notationName');
    check(ent.systemId = 'picture1.gif','wrong systemId');

  // An Entity node does not have any parent. (w3c.org)
  check(ent.parentNode = nil, 'parentNode is defined as nil but is different');

  // get the entities by index
  // independant wich sort order they have
  sl := TStringList.Create;
  for i := 0 to doc.docType.entities.length-1 do begin
    ent := doc.docType.entities[i] as IDomEntity;
    sl.Add(ent.nodeName);
  end;
  check(sl.IndexOf('ct') <> -1, 'entity "ct" not found');
  check(sl.IndexOf('picture1') <> -1, 'entity "piture1" not found');

  ent := doc.docType.entities[sl.IndexOf('ct')] as IDomEntity;
    check(ent.nodeName = 'ct', 'wrong nodeName');
    check(doc.documentElement.firstChild.nodeType = ENTITY_REFERENCE_NODE, 'wrong nodeType');
    entref := (doc.documentElement.firstChild as IDOMEntityReference);
    check(entref.nodeName = 'ct', 'wrong nodeName');

  ent := doc.docType.entities[sl.IndexOf('picture1')] as IDomEntity;
    check(ent.notationName = 'gif', 'wrong notationName');
    check(ent.systemId = 'picture1.gif', 'wrong systemId');
    check(ent.nodeName = 'picture1', 'wrong nodeName');

  sl.Free;
end;

procedure TTestDOM2Methods.ext_docType_notations;
const
  xmlstr2 = xmldecl +
          '<!DOCTYPE root [' + '<!ELEMENT root (test*)>' +
          '<!ELEMENT test (#PCDATA)>' +
          '<!ATTLIST test name CDATA #IMPLIED>' +
          '<!ENTITY ct "4 commerce technologies">' +
          '<!NOTATION gif SYSTEM "gifview.exe">' +
{ TODO : add more notations here }
          '<!ENTITY picture1 SYSTEM "picture1.gif" NDATA gif>' + ']>' +
          '<root />';
var
  i: integer;
  notations: IDomNamedNodeMap;
  node:     IDomNode;
  notation: IDomNotation;
begin
  // there's no DTD !
  check(doc.docType = nil, 'not nil');
  // load xml with dtd
  (doc as IDomPersist).loadxml(xmlstr2);
  check(doc.docType <> nil, 'there is a DTD but docType is nil');
  // get the notations
  notations:=doc.docType.notations;
  check(notations<>nil,'there are notations but the list of notations is nil');
  check(notations.length = 1, 'wrong notations length');
  // get the notation 'gif'
  node:=notations.namedItem['gif'];
  check(node<>nil,'notation gif not found');
  notation:=node as IDomNotation;
  check(notation.systemId='gifview.exe','wrong systemId of notation');
  check(notation.nodeName='gif','wrong notation.nodeName');
  notation := doc.docType.notations[0] as IDOMNotation;
  check(notation <> nil, 'notation is nil');

  for i := 0 to doc.docType.notations.length-1 do begin
{ TODO : restructure this if more notations are added }
    notation := doc.docType.notations[i] as IDOMNotation;
    check(notation.systemId = 'gifview.exe', 'wrong systemId');
    check(notation.nodeName = 'gif', notation.nodeName);
    check(notation.nodeType = NOTATION_NODE, 'wrong nodeType');
    // check(myIsSameNode(notation.parentNode,doc.docType), 'wrong parentNode');
    check(myIsSameNode(notation.ownerDocument,doc), 'wrong ownerDocument');
  end;
end;

procedure TTestDOM2Methods.ext_attribute_specified;
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
var
  attr1,attr2,attr3,attr4: IDOMAttr;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4), 'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap <> nil, 'attributes are nil');
  check(nnmap.length = 3, 'wrong length');


  //debugAttributes(nnmap);
  attr1 := nnmap.namedItem['attr-required'] as IDOMAttr;
  check(attr1<>nil,'attr1 is nil');
  attr2 := nnmap.namedItem['attr-default'] as IDOMAttr;
  check(attr2<>nil,'attr2 is nil');
  attr3 := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr3<>nil,'attr3 is nil');


  // If the attribute has an assigned value in the document
  // then specified is true, and the value is the assigned value
  check(attr1.nodeValue = 'required-value', 'wrong nodeValue (I)');
  check(attr1.specified, 'required attribute is not specified');


  // If the attribute has no assigned value in the document and
  // has a default value in the DTD, then specified is false,
  // and the value is the default value in the DTD
  check(attr2.nodeValue = 'default-value', 'wrong nodeValue (II)');
  check(not attr2.specified, 'default attribute is specified');
  check(attr3.nodeValue = 'fixed-value', 'wrong nodeValue (III)');
  check(not attr3.specified, 'fixed attribute is specified');

  // Check the ownerDocument of the default attribute
  check(attr2.ownerDocument = doc, 'wrong ownerDocument');


  attr4 := attr2.cloneNode(False) as IDOMAttr;
  check(attr4<>nil,'attr4 is nil');
  check(attr4.ownerElement = nil, 'has an ownerElement');
  check(attr4.specified, 'default attribute was cloned and is not specified');

end;

procedure TTestDOM2Methods.ext_attribute_default_removeNamedItem;
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
var
  oe,de: IDOMElement;
  tempNode: IDomNode;
begin
  // get a default attribute from a dtd
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  nnmap := doc.documentElement.attributes;

  //debugAttributes(nnmap);

  check(nnmap.length = 3, 'wrong length');

  attr:=nnmap[0] as IDomAttr;
  attr.name;
  attr.value;

  attr:=nnmap[1] as IDomAttr;
  attr.name;
  attr.value;

  attr:=nnmap[2] as IDomAttr;
  attr.name;
  attr.value;

  // check the 3 items

  // check required
  attr := nnmap.namedItem['attr-required'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil (I)');
  check(attr.value = 'required-value', 'wrong value (I)');

  // check fixed
  attr := nnmap.namedItem['attr-fixed'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil (II)');
  check(attr.value = 'fixed-value', 'wrong value (II)');

  // check default
  attr := nnmap.namedItem['attr-default'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil (III)');
  check(attr.value = 'default-value', 'wrong value (III)');

  // test the parent node (requested by fe)
  oe := attr.ownerElement;
  de := doc.documentElement;
  check(MyIsSameNode(attr.OwnerElement,doc.documentElement), 'wrong parent node');

  // set a different/non-default value
  attr.value := 'non-default-value';
  attr := nnmap.namedItem['attr-default'] as IDOMAttr;
  check(attr.value = 'non-default-value', 'wrong value (IV)');
  check(attr.specified,'attr is not specified, but must');

  attr:=nnmap[0] as IDomAttr;
  attr.name;
  attr.value;

  attr:=nnmap[1] as IDomAttr;
  attr.name;
  attr.value;

  attr:=nnmap[2] as IDomAttr;
  attr.name;
  attr.value;


  // remove the attribute
  tempNode:=nnmap.removeNamedItem('attr-default');
  tempNode.parentNode;
  (tempNode as IDomAttr).ownerElement;

  // test if default value / attribute is restored
  attr := nnmap.namedItem['attr-default'] as IDOMAttr;
  check(attr.value = 'default-value', 'wrong value (V)');
  check(not attr.specified,'attr is specified, but must not');

  // remove the attribute a second time, to check that no exception is raised
  nnmap.removeNamedItem('attr-default');

  // test if default value / attribute is restored
  attr := nnmap.namedItem['attr-default'] as IDOMAttr;
  check(attr.value = 'default-value', 'wrong value (VI)');
  check(not attr.specified,'attr is specified, but must not');

end;

procedure TTestDOM2Methods.ext_attribute_default2;
var
  sl: TStrings;
  i: integer;
begin
  // get the attributes via index
  // but independent wich index they have
  // because we don't want to test for a spezific sort order

  sl := TStringList.Create;
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');

  // get the original attributes

  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length (I)');

  for i := 0 to nnmap.length-1 do begin
    attr := nnmap.item[i] as IDOMAttr;
    sl.Add(attr.name);
  end;

  if sl.IndexOf('attr-required') = -1 then fail('attribute "required" not found');
  if sl.IndexOf('attr-fixed') = -1    then fail('attribute "fixed" not found');
  if sl.IndexOf('attr-default') = -1  then fail('attribute "default" not found');

  attr := nnmap.item[sl.IndexOf('attr-required')] as IDOMAttr;
  check(attr.value = 'required-value', 'wrong value (I)');

  attr := nnmap.item[sl.IndexOf('attr-fixed')] as IDOMAttr;
  check(attr.value = 'fixed-value', 'wrong value (II)');

  attr := nnmap.item[sl.IndexOf('attr-default')] as IDOMAttr;
  check(attr.value = 'default-value', 'wrong value (III)');

  sl.free;

  // change the original attributes

  attr.value := 'non-default-value';

  // get the changed attributes

  nnmap := doc.documentElement.attributes;
  check(nnmap.length = 3, 'wrong length (II)');

  sl := TStringList.Create;

  for i := 0 to nnmap.length-1 do begin
    attr := nnmap.item[i] as IDOMAttr;
    sl.Add(attr.name);
  end;

  if sl.IndexOf('attr-required') = -1 then fail('attribute "required" not found');
  if sl.IndexOf('attr-fixed') = -1    then fail('attribute "fixed" not found');
  if sl.IndexOf('attr-default') = -1  then fail('attribute "default" not found');

  attr := nnmap.item[sl.IndexOf('attr-required')] as IDOMAttr;
  check(attr.value = 'required-value', 'wrong value (IV)');

  attr := nnmap.item[sl.IndexOf('attr-fixed')] as IDOMAttr;
  check(attr.value = 'fixed-value', 'wrong value (V)');

  attr := nnmap.item[sl.IndexOf('attr-default')] as IDOMAttr;
  check(attr.value = 'non-default-value', 'wrong value (VI)');

  sl.free;
end;

procedure TTestDOM2Methods.ext_attribute_default3;
var
  i: integer;
begin
  check((doc as IDOMPersist).loadxml(xmlstr4),'parse error');
  attr := doc.documentElement.attributes.namedItem['attr-default'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil (0)');
  check(attr.name = 'attr-default', 'wrong name');
  check(attr.value = 'default-value', 'wrong value (0)');
  for i := 0 to 9 do begin
    attr.value := 'value-'+IntToStr(i);
    attr := doc.documentElement.attributes.namedItem['attr-default'] as IDOMAttr;
    check(attr <> nil, 'attribute is nil ('+IntToStr(i)+')');
    check(attr.value = 'value-'+IntToStr(i), 'wrong value ('+IntToStr(i)+')');
  end;
end;

procedure TTestDOM2Methods.ext_docType_entities1;
const
  xmlstr = '<?xml version=''1.0''?>'+CRLF+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (#PCDATA) >'+CRLF+
           '<!ENTITY % xx ''&#37;zz;''>'+CRLF+
           '<!ENTITY % zz ''&#60;!ENTITY tricky "error-prone" >'' >'+CRLF+
           '%xx;'+CRLF+
           ']>'+CRLF+
           '<test>This sample shows a &tricky; method.</test>';
begin
  (doc as IDOMParseOptions).resolveExternals := True;
  (doc as IDOMParseOptions).validate := True;
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  check(doc.documentElement.firstChild.nodeValue = 'This sample shows a error-prone method.', 'wrong value');
end;

procedure TTestDOM2Methods.ext_attribute_default4;
const
  xmlstr = '<?xml version=''1.0''?>'+CRLF+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (list1,list2)>'+CRLF+
           '<!ELEMENT list1 (#PCDATA)>'+CRLF+
           '<!ATTLIST list1 type (bullets|ordered|glossary) "ordered">'+CRLF+
           '<!ELEMENT list2 (#PCDATA)>'+CRLF+
           '<!ATTLIST list2 type (bullets|ordered|glossary) #IMPLIED>'+CRLF+
           ']>'+CRLF+
           '<test><list1 /><list2 /></test>';
var temp: string;
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  nnmap := doc.documentElement.firstChild.attributes;
  attr := nnmap.namedItem['type'] as IDOMAttr;
  temp := attr.nodeValue;
  check(temp = 'ordered', 'wrong value');
end;

procedure TTestDOM2Methods.ext_docType_entities_externalDTD;
var
  sl: TStrings;
  i:  integer;
begin
  // load a xml file with an external dtd
  (doc as IDOMParseOptions).resolveExternals := True;
  (doc as IDOMParseOptions).validate := True;
  check((doc as IDOMPersist).load(datapath+'test-dtd.xml'), 'parse error');

  // check if the entity reference is resolved
  check(doc.documentElement.firstChild.nodeValue = 'bar1', 'wrong value');

  // get the entities by index independant wich sort order they have
  sl := TStringList.Create;
  for i := 0 to doc.docType.entities.length-1 do begin
    ent := doc.docType.entities[i] as IDOMEntity;
    sl.Add(ent.nodeName);
  end;

  // check if they are all there
  for i := 0 to 4 do begin
    check(sl.IndexOf('FOO'+IntToStr(i)) <> -1, 'entity FOO'+IntToStr(i)+' not found');
  end;

  sl.Free;
end;

procedure TTestDOM2Methods.ext_docType_notations_externalDTD;
var
  sl: TStrings;
  i:  integer;
begin
  // load a xml file with an external dtd
  (doc as IDOMParseOptions).resolveExternals := True;
  (doc as IDOMParseOptions).validate := True;
  check((doc as IDOMPersist).load(datapath+'test-dtd.xml'), 'parse error');

  // check if the entity reference is resolved
  check(doc.documentElement.firstChild.nodeValue = 'bar1', 'wrong value');

  // get the notations by index independant wich sort order they have
  sl := TStringList.Create;
  for i := 0 to doc.docType.notations.length-1 do begin
    nota := doc.docType.notations[i] as IDOMNotation;
    sl.Add(nota.nodeName);
  end;

  // check if they are all there
  for i := 0 to 4 do begin
    check(sl.IndexOf('type'+IntToStr(i)) <> -1, 'notation type'+IntToStr(i)+' not found');
  end;

  sl.Free;
end;

procedure TTestDOM2Methods.ext_docType_entities_external_internalDTD;
var
  temp,dp: string;
  i: integer;
  sl: TStrings;
begin
  dp := StringReplace(datapath,'\','/',[rfReplaceAll]);
  temp :=  xmldecl+CRLF+
           '<!DOCTYPE TEST-DTD SYSTEM "'+dp+'test-dtd.dtd" ['+CRLF+
           '<!ENTITY abc "abcdefghijklmnopqrstuvwyxz" >'+CRLF+
           '<!ENTITY FOO0 "bazzz" >'+CRLF+
           ']>'+CRLF+
           '<TEST-DTD>&FOO0;</TEST-DTD>';
  (doc as IDOMParseOptions).resolveExternals := True;
  (doc as IDOMParseOptions).validate := True;
  check((doc as IDOMPersist).loadxml(temp), 'parse error');

  sl := TStringList.Create;
  for i := 0 to doc.docType.entities.length-1 do begin
    ent := doc.docType.entities[i] as IDOMEntity;
    sl.Add(ent.nodeName);
  end;

  // check if they are all there
  check(sl.IndexOf('abc') <> -1, 'entity abc not found');
  for i := 0 to 4 do begin
    check(sl.IndexOf('FOO'+IntToStr(i)) <> -1, 'entity FOO'+IntToStr(i)+' not found');
  end;

  // If both the external and internal subsets are used, the internal subset is
  // considered to occur before the external subset. This has the effect that
  // entity and attribute-list declarations in the internal subset take
  // precedence over those in the external subset. (w3c.org)

  // check if the right entity is resolved
  check(doc.documentElement.firstChild.nodeValue = 'bazzz', 'wrong nodeValue');

  sl.Free;
end;

procedure TTestDOM2Methods.ext_attribute_default5;
const
  xmlstr = '<?xml version=''1.0''?>'+CRLF+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (list1,list2)>'+CRLF+
           '<!ELEMENT list1 (#PCDATA)>'+CRLF+
           '<!ATTLIST list1 type CDATA "ordered">'+CRLF+
           '<!ELEMENT list2 (#PCDATA)>'+CRLF+
           '<!ATTLIST list2 type CDATA #IMPLIED>'+CRLF+
           ']>'+CRLF+
           '<test><list1 /><list2 /></test>';
var temp: string;
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  temp := (doc.documentElement.firstChild as IDOMElement).getAttribute('type');
  check(temp = 'ordered', 'wrong value');
end;

procedure TTestDOM2Methods.ext_docType_entities2;
var
  dp,temp,src,feature: string;
begin
  // libxml works with fore-slashes
  dp := StringReplace(datapath,'\','/',[rfReplaceAll]);

  (doc as IDOMParseOptions).resolveExternals := True;
  (doc as IDOMParseOptions).validate := True;

  feature := 'IGNORE';
  src := xmldecl+CRLF+
         '<!DOCTYPE test ['+CRLF+
         '<!ENTITY % feature-test "'+feature+'">'+CRLF+
         '<!ENTITY % external-subset SYSTEM "'+dp+'feature-test.dtd">'+CRLF+
         '%external-subset;'+CRLF+
         ']>'+CRLF+
         '<test>&e1;/&e2;</test>';

  check((doc as IDOMPersist).loadxml(src), 'parse error (I)');
  temp := doc.documentElement.firstChild.nodeValue;
  check(temp = 'xxx/yyy', 'wrong value');

  feature := 'INCLUDE';
  src := xmldecl+CRLF+
         '<!DOCTYPE test ['+CRLF+
         '<!ENTITY % feature-test "'+feature+'">'+CRLF+
         '<!ENTITY % external-subset SYSTEM "'+dp+'feature-test.dtd">'+CRLF+
         '%external-subset;'+CRLF+
         ']>'+CRLF+
         '<test>&e1;/&e2;</test>';

  check((doc as IDOMPersist).loadxml(src), 'parse error (II)');
  temp := doc.documentElement.firstChild.nodeValue;
  check(temp = 'aaa/bbb', 'wrong value');
end;

procedure TTestDOM2Methods.ext_attribute_default_getAttribute;
const
  xmlstr = xmldecl+CRLF+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (#PCDATA)>'+CRLF+
           '<!ATTLIST test defattr CDATA "defval">'+CRLF+
           ']>'+CRLF+
           '<test/>';
var
  temp: string;
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  check(doc.documentElement.hasAttributes,
    'there are no attributes attached to the element');
  check(doc.documentElement.hasAttribute('defattr'),
    'there is no attribute "defattr" attached to the element');

  // check the default value of the attribute
  temp := doc.documentElement.getAttribute('defattr');
  check(temp = 'defval', 'wrong value (I)');

  // set a non-default value of the attribute
  doc.documentElement.setAttribute('defattr','newval');
  temp := doc.documentElement.getAttribute('defattr');
  check(temp = 'newval', 'wrong value (II)');

  // check the restored value of the attribute
  doc.documentElement.removeAttribute('defattr');
  temp := doc.documentElement.getAttribute('defattr');
  check(temp = 'defval', 'wrong value (III)');
end;

procedure TTestDOM2Methods.ext_attribute_default_getAttributeNode;
const
  xmlstr = xmldecl+CRLF+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (#PCDATA)>'+CRLF+
           '<!ATTLIST test defattr CDATA "defval">'+CRLF+
           ']>'+CRLF+
           '<test/>';
var
  attr1: IDOMAttr;
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  check(doc.documentElement.hasAttributes,
    'there are no attributes attached to the element');
  check(doc.documentElement.hasAttribute('defattr'),
    'there is no attribute "defattr" attached to the element');

  // check the default value of the attribute
  attr := doc.documentElement.getAttributeNode('defattr');
  check(attr.value = 'defval', 'wrong value (I)');
  attr1 := attr.cloneNode(False) as IDOMAttr;
  check(MyIsSameNode(attr1.ownerDocument,doc),'wrong owner document');
  check(attr1.name='defattr');

  // set a non-default value of the attribute
  attr1.value := 'newval';
  doc.documentElement.setAttributeNode(attr1);
  attr := doc.documentElement.getAttributeNode('defattr');
  check(attr.value = 'newval', 'wrong value (II)');

  // check the restored value of the attribute
  doc.documentElement.removeAttributeNode(attr);
  attr := doc.documentElement.getAttributeNode('defattr');
  check(attr.value = 'defval', 'wrong value (III)');
end;

procedure TTestDOM2Methods.ext_attribute_default_getAttributeNS;
const
  xmlstr = xmldecl+CRLF+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (#PCDATA)>'+CRLF+
           '<!ATTLIST test xmlns:def CDATA "DEF">'+CRLF+
           '<!ATTLIST test def:attr CDATA "defval">'+CRLF+
           ']>'+CRLF+
           '<test/>';
var
  temp: string;
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  check(doc.documentElement.hasAttributes,
    'there are no attributes attached to the element');
  check(doc.documentElement.hasAttributeNS('DEF','attr'),
    'there is no attribute "def:attr" attached to the element');

  // check the default value of the attribute
  temp := doc.documentElement.getAttributeNS('DEF','attr');
  check(temp = 'defval', 'wrong value (I)');

  // set a non-default value of the attribute
  doc.documentElement.setAttributeNS('DEF','def:attr','newval');
  temp := doc.documentElement.getAttributeNS('DEF','attr');
  check(temp = 'newval', 'wrong value (II)');

  // check the restored value of the attribute
  doc.documentElement.removeAttributeNS('DEF','attr');
  temp := doc.documentElement.getAttributeNS('DEF','attr');
  check(temp = 'defval', 'wrong value (III)');

  // check if another removal produces an exception
  doc.documentElement.removeAttributeNS('DEF','attr');
  temp := doc.documentElement.getAttributeNS('DEF','attr');
  check(temp = 'defval', 'wrong value (IV)');
end;

procedure TTestDOM2Methods.ext_attribute_default_getAttributeNodeNS;
const
  xmlstr = xmldecl+CRLF+
           '<!DOCTYPE test ['+CRLF+
           '<!ELEMENT test (#PCDATA)>'+CRLF+
           '<!ATTLIST test xmlns:def CDATA "DEF">'+CRLF+
           '<!ATTLIST test def:attr CDATA "defval">'+CRLF+
           ']>'+CRLF+
           '<test/>';
var
  attr1: IDomAttr;
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  check(doc.documentElement.hasAttributes,
    'there are no attributes attached to the element');
  check(doc.documentElement.hasAttributeNS('DEF','attr'),
    'there is no attribute "def:attr" attached to the element');

  // check the default value of the attribute
  attr := doc.documentElement.getAttributeNodeNS('DEF','attr');
  check(attr.value = 'defval', 'wrong value (I)');
  check(attr.namespaceURI='DEF');
  check(not attr.specified,'attribute is specified');

  attr1:= attr.cloneNode(false) as IDomAttr;
  check(attr1.namespaceURI='DEF','cloned default attr has wrong namespaceURI');

  // set a non-default value of the attribute
  attr1.value := 'newval';
  doc.documentElement.setAttributeNodeNS(attr1);
  attr := doc.documentElement.getAttributeNodeNS('DEF','attr');
  check(attr.value = 'newval', 'wrong value (II)');

  // check the restored value of the attribute
  doc.documentElement.removeAttributeNode(attr);
  attr := doc.documentElement.getAttributeNodeNS('DEF','attr');
  check(attr.value = 'defval', 'wrong value (III)');

  // check if another removal produces an exception
  doc.documentElement.removeAttributeNode(attr);
  attr := doc.documentElement.getAttributeNodeNS('DEF','attr');
  check(attr.value = 'defval', 'wrong value (III)');
end;

function TTestDOM2Methods.getFragmentA(out docstr: WideString): IDOMElement;
var
  doc: IDOMDocument;
  elem1,elem2: IDOMElement;
  i,j,n: integer;
  sl: TStrings;
  domdebug: IDOMDebug;
begin
  result := nil;
  n := 0;
  sl := TStringList.Create;
  sl.Add('abc=http://abc.org');
  sl.Add('def=http://def.org');
  sl.Add('ghi=http://ghi.org');
  doc := impl.createDocument('','',nil);
  if impl.QueryInterface(IDOMDebug,domdebug) = S_OK then begin
    domdebug.doccount;
  end;

  if (doc as IDOMPersist).loadxml(xmlstr) then begin
    elem1 := doc.createElement('test');
    doc.documentElement.appendChild(elem1);
    result := elem1;
    // how many childnodes of documentElement
    for j := 0 to 9 do begin
      elem2 := result;
      // how deep
      for i := 0 to 9 do begin
        elem1 := doc.createElementNS(sl.Values[sl.Names[n]],sl.Names[n]+':elem');
        Inc(n);
        if n > 2 then n := 0;
        elem1.setAttributeNS(sl.Values[sl.Names[n]],sl.Names[n]+':attr',IntToStr(i));
        elem2.appendChild(elem1);
        elem1 := elem1.cloneNode(true) as IDOMElement;
        elem2.appendChild(elem1);
        Inc(n);
        if n > 2 then n := 0;
        elem2 := elem1;
      end;
    end;
  end;
  docstr := (doc as IDOMPersist).xml;
  sl.Free;
end;

procedure writeTextFile(filename,text: string);
var
  fileHandle: integer;
  error: integer;
begin
  fileHandle:=FileCreate(filename);
  error := FileWrite(fileHandle,text,length(text));
  if error = -1 then raise Exception.Create('an error occurs while writing the text file "'+filename+'"');
  FileClose(fileHandle);
end;

procedure TTestDOM2Methods.ext_importNode_cloneNode;
// test the methods cloneNode and importNode with a complicated
// docfragment.
// 1. create the complicated docfragment
// 2. clone it
// 3. import it into a second document
// 4. check, whether it is the same
// 5. check, whether all nodes of the imported tree have the right
//    OwnerDocument

// without the last check, the test is passed by msxml
{$define docCheck}
var
  elem1,elem2,elemb: IDOMElement;
  docstr: WideString;
  domdebug: IDOMDebug;
  i,j: integer;
begin
  // delete all documents => doccount should be zero
  doc := nil;
  doc0 := nil;
  doc1 := nil;
  if impl.QueryInterface(IDOMDebug,domdebug) = S_OK then begin
    check(domdebug.doccount = 0, 'wrong doccount (I)');
  end;

  elemb := getFragmentA(docstr);

  elemb.ownerDocument.nodeName;
  // the following line just tests, wether cloneNode works
  // correctly, importNode Clones a Node, too
  elem := (elemb.cloneNode(true)) as IDomElement;
  check(((elem as IDomNodeExt).xml=(elemb as IDomNodeExt).xml),'clone error');

  elemb:=nil;
  if impl.QueryInterface(IDOMDebug,domdebug) = S_OK then begin
    // in the procedure getFragmentA a new document was created,
    // it does still exist, because elem.ownerDocument still keeps
    // a reference to it
    check(domdebug.doccount = 1, 'wrong doccount (II)');
  end;

  doc := impl.createDocument('','',nil);
  (doc as IDOMPersist).loadxml(xmlstr);

  elem := doc.importNode(elem as IDOMNode,true) as IDOMElement;
  elem.nodeName;

  doc.documentElement.appendChild(elem);

  // writeTextFile('A_'+domvendor+'.txt',prettyPrint(docstr));
  // writeTextFile('B_'+domvendor+'.txt',prettyPrint((doc as IDOMPersist).xml));
  check((doc as IDOMPersist).xml = docstr, 'different xml structure');

  // check if every element and attribute has the right ownerDocument
  for j := 0 to 9 do begin
    elem1 := doc.documentElement.firstChild as IDOMElement;
    for i := 0 to 9 do begin

      // check the firstChild
      elem2 := elem1.firstChild as IDOMElement;
      check(assigned(elem2),'elem2 is nil');

      {$ifdef docCheck}
      check(MyIsSameNode(elem2.ownerDocument,doc), 'wrong ownerDocument A'+IntToStr(j*10+i));
      {$endif}
      check(elem2.hasAttributes, 'has no attributes');
      attr := elem2.attributes[0] as IDOMAttr;
      {$ifdef docCheck}
      check(MyIsSameNode(attr.ownerDocument,doc), 'wrong ownerDocument B'+IntToStr(j*10+i));
      {$endif}
      // check the lastChild
      elem2:=elem1.lastChild as IDOMElement;
      {$ifdef docCheck}
      check(MyIsSameNode(elem2.ownerDocument,doc), 'wrong ownerDocument C'+IntToStr(j*10+i));
      {$endif}
      check(elem2.hasAttributes, 'has no attributes');
      attr := elem2.attributes[0] as IDOMAttr;
      {$ifdef docCheck}
      check(MyIsSameNode(attr.ownerDocument,doc), 'wrong ownerDocument D'+IntToStr(j*10+i));
      {$endif}
      // go on with childs of lastChild
      elem1 := elem2;
    end;
  end;

end;

procedure TTestDOM2Methods.ext_setAttributeNodeNS_Xml;
var
  nsuri1,nsuri2: string;
begin
  nsuri1 := 'http://abc.org';
  nsuri2 := 'http://def.org';
  elem := doc.createElementNS(nsuri1,'abc:elem');
  attr := doc.createAttributeNS(nsuri2,'def:attr1');
  attr.value := 'value of 1st attr';
  elem.setAttributeNodeNS(attr);
  attr := doc.createAttributeNS(nsuri2,'def:attr2');
  attr.value := 'value of 2nd attr';
  elem.setAttributeNodeNS(attr);
  doc.documentElement.appendChild(elem);
end;

procedure TTestDOM2Methods.ext_setNamedItemNS_Xml;
var
  nsuri1,nsuri2: string;
begin
  nsuri1 := 'http://abc.org';
  nsuri2 := 'http://def.org';
  elem := doc.createElementNS(nsuri1,'abc:elem');
  attr := doc.createAttributeNS(nsuri2,'def:attr1');
  attr.value := 'value of 1st attr';
  elem.attributes.setNamedItemNS(attr);
  attr := doc.createAttributeNS(nsuri2,'def:attr2');
  attr.value := 'value of 2nd attr';
  elem.attributes.setNamedItemNS(attr);
  doc.documentElement.appendChild(elem);
end;

procedure TTestDOM2Methods.ext_cloneNode_AttributeNode_default;
const
  xmlstr = xmldecl+
           '<!DOCTYPE test ['+
           '<!ELEMENT test (elem1,elem2)>'+
           '<!ELEMENT elem1 (#PCDATA)>'+
           '<!ELEMENT elem2 (#PCDATA)>'+
           '<!ATTLIST elem1 defattr CDATA "defvalue">'+
           ']>'+
           '<test><elem1/><elem2/></test>';
var
  attr1: IDOMAttr;
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  check(doc.documentElement.hasChildNodes, 'there are no childNodes');
  check(doc.documentElement.childNodes.length = 2, 'wrong length of childNodes');
  check(doc.documentElement.firstChild.hasAttributes, 'there are no attributes');
  check(not doc.documentElement.lastChild.hasAttributes, 'there are attributes');
  elem := doc.documentElement.firstChild as IDOMElement;
  attr := elem.getAttributeNode('defattr');
  check(not attr.specified, 'attribute is specified but it''s a default attribute');
  attr1 := attr.cloneNode(False) as IDOMAttr;
  check(attr1 <> nil, 'node is nil');
  check(not MyIsSameNode(attr,attr1),'target and source are the same');
{ TODO : discuss if this is necessary
  elem := doc.documentElement.lastChild as IDOMElement;
  elem.setAttributeNode(attr1);
}
  check(attr1.specified, 'attribute is not specified but was cloned');
end;

procedure TTestDOM2Methods.unknown_PrettyPrint;
  (* recurse function *)
  function get_xml(node: IDOMNode; indentlevel: integer = 0): string;
    (* return name="value" string *)
    function get_attr(name,value: string): string;
    begin
      result := ' '+name+'="'+value+'"';
    end;
    (* return namespace declaration string *)
    function get_xmlns(node: IDOMNode): string;
    begin
      result := '';
      if Assigned(node)
        then if node.prefix <> ''
          then result := get_attr('xmlns:'+node.prefix,node.namespaceURI);
    end;
  const indentstr = '--';
  var i: integer;
  begin
    result := '';
    if Assigned(node) then begin
      if node.nodeType = TEXT_NODE then begin
        result := node.nodeValue+CRLF;
      end else begin
        result := result+'<'+node.nodeName;
        result := result+get_xmlns(node);
        if node.hasAttributes then begin
          for i := 0 to node.attributes.length-1 do begin
            result := result+get_attr(node.attributes[i].nodeName,node.attributes[i].nodeValue);
            result := result+get_xmlns(node.attributes[i]);
          end;
        end;
        if node.hasChildNodes then begin
          result := result+'>'+CRLF;
          for i := 0 to node.childNodes.length-1 do begin
            result := result+DupeString(indentstr,indentlevel+1)+get_xml(node.childNodes[i], indentlevel+1);
          end;
          result := result+DupeString(indentstr,indentlevel)+'</'+node.nodeName+'>'+CRLF;
        end else begin
          result := result+'/>'+CRLF;
        end;
      end;
    end;
  end;
const
  xmlstr = xmldecl+
           '<root>'+
           '<child-1>'+
           '<child-1-1 attr="1-1"/>'+
           '<child-1-2 attr="1-2"/>'+
           '</child-1>'+
           '<child-2 attr="2"/>'+
           '<child-3 attr="3"/>'+
           '<child-4 ct:attr="4ct" xmlns:ct="http://ns.4commerce.de" />'+
           '<abc:elem xmlns:abc="http://abc.org"/>'+
           '<child-5>Hallo Welt.</child-5>'+
           '</root>';

var
  temp: string;
begin
  (doc as IDOMPersist).loadxml(xmlstr);
  temp := xmldecl + CRLF + get_xml(doc.documentElement);
  //showMessage(temp);
end;

procedure TTestDOM2Methods.unknown_PrettyPrint1;
const
  xmlstr = xmldecl+
           '<root>'+
           '<child-1>'+
           '<child-1-1 attr="1-1"/>'+
           '<child-1-2 attr="1-2"/>'+
           '</child-1>'+
           '<child-2 attr="2"/>'+
           '<child-3 attr="3"/>'+
           '<child-4 ct:attr="4ct" xmlns:ct="http://ns.4commerce.de" />'+
           '<abc:elem xmlns:abc="http://abc.org"/>'+
           '<child-5>Hallo Welt.</child-5>'+
           '<child-6><![CDATA[<name/>]]></child-6>'+
           '</root>';
var
  temp: string;
  prettyxml: string;
begin
  (doc as IDOMPersist).loadxml(xmlstr);
  temp := (doc as IDOMPersist).xml;
  prettyxml := PrettyPrint(temp);
  //showMessage('"'+prettyxml+'"');
end;

procedure TTestDOM2Methods.ext_reconciliate1;
const
  xmlstr0 = xmldecl+
            '<ct:root xmlns:ct="ABC">'+
            '<ct:child />'+
            '</ct:root>';
  xmlstr1 = xmldecl+
            '<root/>';
  xmlstr2 = xmldecl+
            '<root xmlns:ct="DEF"/>';
begin
  check((doc0 as IDOMPersist).loadxml(xmlstr0),'parse error xmlstr0');
  node := doc0.documentElement.firstChild;
  check((doc1 as IDOMPersist).loadxml(xmlstr1),'parse error xmlstr1');
  node := doc1.importNode(node,False);
  check(node <> nil, 'imported node is nil (I)');
  doc1.documentElement.appendChild(node);
  check(Unify((doc1 as IDOMPersist).xml) = '<root><ct:child xmlns:ct="ABC"/></root>', 'wrong content');
  check((doc as IDOMPersist).loadxml(xmlstr2),'parse error xmlstr2');
  node := doc.importNode(node,False);
  check(node <> nil, 'imported node is nil (II)');
  doc.documentElement.appendChild(node);
  //showMessage(Unify((doc as IDOMPersist).xml));
  check(Unify((doc as IDOMPersist).xml) = '<root xmlns:ct="DEF"><ct:child xmlns:ct="ABC"/></root>');
end;

procedure TTestDOM2Methods.ext_namedNodeMap_append_remove_NsDecl1;
const
  xmlstr =  xmldecl+
            '<root>'+
            '<child1 xmlns:abc="ABC"'+
                   ' xmlns:ct="CT"'+
                   ' attr1="value-of-attr1"'+
                   ' ct:attr1="value-of-ct:attr1"/>'+
            '<child2/>'+
            '</root>';
  xmlstr1 = '<root>'+
            '<child1 xmlns:abc="ABC"'+
                   ' xmlns:ct="CT"'+
                   ' attr1="value-of-attr1"/>'+
            '<child2 xmlns:ct="CT"'+
                   ' ct:attr1="value-of-ct:attr1"/>'+
            '</root>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  nnmap := doc.documentElement.firstChild.attributes;
  node := nnmap.removeNamedItemNS('CT','attr1');
  check(node <> nil, 'namedItem not removed probably not found');
  nnmap := doc.documentElement.lastChild.attributes;
  nnmap.setNamedItemNS(node);
  //showMessage(Unify((doc as IDOMPersist).xml));
  check(Unify((doc as IDOMPersist).xml) = xmlstr1, 'wrong content');
end;

procedure TTestDOM2Methods.ext_namedNodeMap_append_remove_NsDecl2;
const
  xmlstr =  xmldecl+
            '<root xmlns:ct="CT">'+
            '<child1 xmlns:abc="ABC"'+
                   ' attr1="value-of-attr1"'+
                   ' ct:attr1="value-of-ct:attr1"/>'+
            '<child2/>'+
            '</root>';
  xmlstr1 = '<root xmlns:ct="CT">'+
            '<child1 xmlns:abc="ABC"'+
                   ' attr1="value-of-attr1"/>'+
            '<child2 ct:attr1="value-of-ct:attr1"/>'+
            '</root>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  nnmap := doc.documentElement.firstChild.attributes;
  node := nnmap.removeNamedItemNS('CT','attr1');
  check(node <> nil, 'namedItem not removed probably not found');
  nnmap := doc.documentElement.lastChild.attributes;
  nnmap.setNamedItemNS(node);
  //debugDom(doc,true);
  check(Unify((doc as IDOMPersist).xml) = xmlstr1, 'wrong content');
end;

procedure TTestDOM2Methods.ext_insertBefore_existing;
var oldsecond: IDOMNode;
begin
  node := doc.createElement('first');
  // If refChild is null, insert newChild at the end of the list of children. (w3c.org)
  try
    doc.documentElement.insertBefore(node,nil);
  except
    fail('there should have been no exception');
  end;
  check(doc.documentElement.childNodes.length = 1, 'wrong length (I)');
  node := doc.createElement('second');
  oldsecond := node;
  doc.documentElement.insertBefore(node,doc.documentElement.firstChild);
  check(doc.documentElement.childNodes.length = 2, 'wrong length (II)');
  node := doc.createElement('third');
  doc.documentElement.insertBefore(node,doc.documentElement.firstChild);
  check(doc.documentElement.childNodes.length = 3, 'wrong length (III)');
  // 'third' is now the first
  // 'second' is now the second
  // 'first' is now the last
  node := doc.documentElement.firstChild;
  check(node.nodeName = 'third', 'wrong nodeName (I)');
  node := node.nextSibling;
  check(node.nodeName = 'second', 'wrong nodeName (II)');
  node := node.nextSibling;
  check(node.nodeName = 'first', 'wrong nodeName (III)');
  // If the newChild is already in the tree, it is first removed. (w3c.org)
  doc.documentElement.insertBefore(oldsecond,doc.documentElement.firstChild);
  check(doc.documentElement.childNodes.length = 3, 'wrong length (IV)');
  // 'second' is now the first
  // 'third' is now the second
  // 'first' is now the last
  node := doc.documentElement.firstChild;
  check(node.nodeName = 'second', 'wrong nodeName (I)');
  node := node.nextSibling;
  check(node.nodeName = 'third', 'wrong nodeName (II)');
  node := node.nextSibling;
  check(node.nodeName = 'first', 'wrong nodeName (III)');
end;

procedure TTestDOM2Methods.ext_insertBefore_10times;
const n = 10;
var
  oldnode: IDOMNode;
  i: integer;
begin
  oldnode := nil;
  for i := 0 to n-1 do begin
    node := doc.createElement('child'+IntToStr(i));
    try
      doc.documentElement.insertBefore(node,oldnode);
    except
      fail('there should have been no exception');
    end;
    oldnode := node;
  end;
  check(doc.documentElement.childNodes.length = n, 'wrong length');
  for i := 0 to n-1 do begin
    node := doc.documentElement.childNodes[i];
    check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
    check(node.nodeName = 'child'+IntToStr(n-i-1), 'wrong nodeName');
  end;
end;

procedure TTestDOM2Methods.ext_insertBefore_TextNode;
// some dom-implementations merge adjescent text node, if appended
// this check will be ok in both cases (with and without merging)
var
  oldtext: IDOMText;
begin
  text := doc.createTextNode('first');
  doc.documentElement.appendChild(text);
  check(doc.documentElement.childNodes.length = 1, 'wrong length (I)');
  oldtext := text;
  text := doc.createTextNode('second');
  doc.documentElement.insertBefore(text,oldtext);
  //check(doc.documentElement.childNodes.length = 2, 'wrong length (II)');
  //doc.documentElement.insertBefore(oldtext,doc.documentElement.firstChild);
  //check(doc.documentElement.childNodes.length = 2, 'wrong length (III)');
  node := doc.documentElement.firstChild;
  check(node.nodeType = TEXT_NODE, 'wrong nodeType');
  check(node.nodeName = '#text', 'wrong nodeName');
  if doc.documentElement.childNodes.length=2 then begin
    check(node.nodeValue = 'second', 'wrong nodeValue');
    node := node.nextSibling;
    check(node.nodeType = TEXT_NODE, 'wrong nodeType');
    check(node.nodeName = '#text', 'wrong nodeName');
    check(node.nodeValue = 'first', 'wrong nodeValue');
    end else begin
      check(doc.documentElement.childNodes.length=1,'not correctly merged');
      check(node.nodeValue = 'secondfirst', 'wrong nodeValue');
  end;
end;

procedure TTestDOM2Methods.ext_appendChild_NsDecl;
const
  xmlstr0 = xmldecl+
            '<root>'+
              '<elem1 xmlns:abc="ABC">'+
                '<elem2/>'+
              '</elem1>'+
            '</root>';
  xmlstr1 = '<root>'+
              '<elem1 xmlns:abc="ABC">'+
                '<elem2>'+
                  '<elem3>'+
                    '<abc:elem4/>'+
                  '</elem3>'+
                '</elem2>'+
              '</elem1>'+
            '</root>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr0), 'parse error');
  node := doc.createElement('elem3');
  elem := doc.createElementNS('ABC','abc:elem4');
  node.appendChild(elem);
  doc.documentElement.firstChild.firstChild.appendChild(node);
  //showMessage(Unify((doc as IDOMPersist).xml));
  check(Unify((doc as IDOMPersist).xml) = xmlstr1, 'wrong content');
end;

procedure TTestDOM2Methods.ext_cloneNode_document;
begin
  // cloning a document node is implementation dependent (www.w3c.org)
  node := doc.cloneNode(True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,doc), 'target and source are the same');
  check(node.ownerDocument = nil, 'ownerDocument is not nil');
  check(node.nodeName = '#document', 'wrong nodeName');
  check(node.nodeType = DOCUMENT_NODE, 'wrong nodeType');
  check(node.hasChildNodes, 'there are no childNodes');
  doc1 := node as IDOMDocument;
  check((doc as IDOMPersist).xml = (doc1 as IDOMPersist).xml, 'different content');
end;

procedure TTestDOM2Methods.basic_cloneNode_DocumentFragment;
const
  n = 10;
var
  i: integer;
  docfrag1: IDOMDocumentFragment;
begin
  docfrag := doc.createDocumentFragment;

  // fill the documentFragment
  for i := 0 to n-1 do begin
    node := doc.createElement('elem'+IntToStr(i));
    docfrag.appendChild(node);
  end;
  check(not doc.documentElement.hasChildNodes, 'there are childNodes');

  // clone it
  docfrag1 := docfrag.cloneNode(True) as IDOMDocumentFragment;
  check(docfrag1 <> nil, 'cloned DocumentFragment is nil');
  check(not MyIsSameNode(docfrag1,docfrag), 'target and source are the same');
  check(docfrag1.nodeType = DOCUMENT_FRAGMENT_NODE, 'wrong nodeType (I)');
  check(docfrag1.parentNode = nil, 'parent is not nil');
  check(docfrag1.childNodes.length = n, 'wrong length (I)');

  // append it
  doc.documentElement.appendChild(docfrag);
  check(doc.documentElement.childNodes.length = n, 'wrong length (II)');
  // past appending : docfrag has no more children
  check(docfrag.childNodes.length = 0, 'wrong length');

  // destroy it
  docfrag := nil;

  doc.documentElement.appendChild(docfrag1);
  check(doc.documentElement.childNodes.length = n*2, 'wrong length (III) : '+IntToStr(doc.documentElement.childNodes.length));
end;

procedure TTestDOM2Methods.ext_appendChild_orphan;
const
  n = 10;
var
  i: integer;
begin
  for i := 0 to n-1 do begin
    elem := doc.createElement('test1');
    node := doc.createElement('test2');
    check(not elem.hasChildNodes, 'there are childNodes');
    elem.appendChild(node);
    check(elem.hasChildNodes, 'there are no childNodes');
    elem := nil;
    node := nil;
  end;
end;

procedure TTestDOM2Methods.ext_insertBefore_documentFragment;
const
  n = 10;
var
  i: integer;
  oldnode: IDOMNode;
begin
  docfrag := doc.createDocumentFragment;
  oldnode := nil;
  for i := 0 to n-1 do begin
    node := doc.createElement('elem'+IntToStr(i));
    docfrag.insertBefore(node,oldnode);
    oldnode := node;
  end;
  for i := 0 to n-1 do begin
    node := docfrag.childNodes[i];
    check(node.nodeName = 'elem'+IntToStr(n-i-1), 'wrong nodeName');
  end;
end;

procedure TTestDOM2Methods.ext_cloneNode_getFragmentA;
var
  docstr: WideString;
  outopt,outopt1: IDOMOutputOptions;
begin
  docstr := '';
  elem := getFragmentA(docstr);
  docstr := '';
  check(elem <> nil, 'returned element is nil');
  elem := doc.importNode(elem,True) as IDOMElement;
  check(elem <> nil, 'imported element is nil');
  doc.documentElement.appendChild(elem);
  node := doc.cloneNode(True);
  check(node <> nil, 'cloned document is nil');
  doc1 := nil;
  doc1 := node as IDOMDocument;
  check((doc as IDOMPersist).xml = (doc1 as IDOMPersist).xml, 'different content');
  if S_OK = doc.QueryInterface(IDOMOutputOptions,outopt) then begin
    outopt1 := (doc1 as IDOMOutputOptions);
    check(outopt.parsedEncoding = outopt1.parsedEncoding, 'different parsedEncoding');
  end;
end;

procedure TTestDOM2Methods.ext_cloneNode_documentNS;
begin
  // cloning a document node is implementation dependent (www.w3c.org)
  doc := impl.createDocument('ABC','abc:root',nil);
  node := doc.cloneNode(True);
  doc1 := node as IDOMDocument;
  check(node.ownerDocument = nil, 'wrong ownerDocument');
  check(node.nodeName = '#document', 'wrong nodeName');
  check(node.nodeType = DOCUMENT_NODE, 'wrong nodeType');
  check(node.hasChildNodes, 'there are no childNodes');
  check((doc as IDOMPersist).xml = (doc1 as IDOMPersist).xml, 'different content');
end;

procedure TTestDOM2Methods.ext_cloneNode_NsDecl;
const
  xmlstr0 = xmldecl+
            '<root>'+
              '<elem1 xmlns:abc="ABC">'+
                '<elem2/>'+
              '</elem1>'+
              '<elem1b/>'+
            '</root>';
  xmlstr1 = '<root>'+
              '<elem1 xmlns:abc="ABC">'+
                '<elem2>'+
                  '<elem3><abc:elem4/></elem3>'+
                '</elem2>'+
              '</elem1>'+
              '<elem1b>'+
                '<elem3><abc:elem4 xmlns:abc="ABC"/></elem3>'+
              '</elem1b>'+
            '</root>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr0), 'parse error');
  node := doc.createElement('elem3');
  elem := doc.createElementNS('ABC','abc:elem4');
  node.appendChild(elem);
  doc.documentElement.firstChild.firstChild.appendChild(node);
  node := node.cloneNode(True);
  doc.documentElement.lastChild.appendChild(node);
  check(Unify((doc as IDOMPersist).xml) = xmlstr1, 'wrong content');
end;

procedure TTestDOM2Methods.ext_cloneNode_AttributeNode_default_on_Element;
const
  xmlstr1 = xmldecl+
           '<!DOCTYPE root ['+CRLF+
           '<!ELEMENT root (elem1)>'+CRLF+
           '<!ELEMENT elem1 (elem2)>'+CRLF+
           '<!ELEMENT elem2 (elem3)>'+CRLF+
           '<!ELEMENT elem3 (#PCDATA)>'+CRLF+
           '<!ATTLIST elem3 name CDATA "name-of-elem3">'+CRLF+
           ']>'+
           '<root>'+
             '<elem1>'+
               '<elem2>'+
                 '<elem3/>'+
               '</elem2>'+
             '</elem1>'+
           '</root>';
begin
  // Cloning an element copies all attributes and their values including
  // those generated by the XML processor to represent defaulted attributes.
  // (subtree) In addition, clones of unspecified attribute nodes are specified.

  {
  TODO : look here for importNode

  // the default attributes of the source document are not copied
  // but the default attributes of the target document are assigned
  // if we had the default attributes of the source document
  // then they were specified
  // but they are assigned because they are default attributes of the source document
  // - they are not specified

  (...)

  // specified attribute nodes on the source element are imported...
  // Default attributes are NOT copied, though if the document being
  // imported into defines default attributes for this element name,
  // those are assigned.
  // w3c.org
  }

  check((doc as IDOMPersist).loadxml(xmlstr1), 'parse error (I)');

  // navigate to elem3
  node := doc.documentElement.firstChild.firstChild.firstChild;
  check(node <> nil, 'node is nil');

  // get and check the default attribute
  attr := node.attributes.namedItem['name'] as IDOMAttr;
  check(attr <> nil, 'attr is nil');
  check(attr.value = 'name-of-elem3', 'wrong value (I)');
  check(not attr.specified, 'attr is specified');

  // clone a parent of the node with the default attribute
  node := doc.documentElement.firstChild.cloneNode(True);
  check(node <> nil, 'cloned node is nil');

  // check the cloned attribute
  attr := node.firstChild.firstChild.attributes.namedItem['name'] as IDOMAttr;
  check(attr <> nil, 'cloned attr is nil (I)');
  check(attr.value = 'name-of-elem3', 'wrong value (II)');
{ TODO : discuss if they are specified - i guess uwe not
  check(attr.specified, 'attr is not specified');
}
end;

procedure TTestDOM2Methods.basic_cloneNode_Element_AttrNS_flat;
var elem1: IDomElement;
begin
  // check, wether nsdecl attributes are created, if you clone a node,
  // that has none, with an attribute, that needs one
  node := doc.createAttributeNs('http://def.org', 'def:child');
  elem := doc.createElementNs('http://def.org', 'def:test');
  elem1:= doc.createElement('NAME');
  elem1.setAttributeNode(IDomAttr(node));
  elem.appendChild(elem1);

  // now clone the node flat
  node := elem1.cloneNode(False);
  check(node <> nil, 'is nil');
  check(node.nodeName = 'NAME', 'wrong nodeName');
  check(((node as IDomNodeExt).xml='<NAME xmlns:def="http://def.org" def:child=""/>'),
                   'namespacedecl missing?');
end;

procedure TTestDOM2Methods.basic_cloneNode_TextNode_deep;
begin
  text := doc.createTextNode(Data);
  node := text.cloneNode(True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node, text), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(node.nodeValue = Data, 'wrong nodeValue');
  text := node as IDOMText;
  check(text <> nil, 'Text is nil');
  check(text.length = Length(Data), 'wrong length');
end;

{
procedure TTestDOM2Methods.basic_cloneNode_NodeList_deep;
const n = 10;
var
  i: integer;
  nl: IDOMNodeList;
begin
  node := doc.documentElement;
  for i := 0 to n-1 do begin
    elem := doc.createElement('abc');
    node.appendChild(elem);
    node := node.firstChild;
  end;
  nodelist := doc.getElementsByTagName('abc');
  node := nodelist as IDOMNode;
  check(node <> nil, 'node is nil');
end;
}


procedure TTestDOM2Methods.basic_cloneNode_CDATA_deep;
begin
  cdata := doc.createCDataSection(Data);
  node := cdata.cloneNode(True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node, cdata), 'target and source are the same');
  check(node.parentNode = nil, 'parent is nil');
  check(node.nodeValue = Data, 'wrong nodeValue');
  cdata := node as IDOMCDataSection;
  check(cdata <> nil, 'CDataSection is nil');
  check(cdata.length = Length(Data), 'wrong length');
end;

procedure TTestDOM2Methods.basic_cloneNode_Comment_deep;
begin
  comment := doc.createComment(Data);
  node := comment.cloneNode(True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node, comment), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(node.nodeValue = Data, 'wrong node value');
  comment := node as IDOMComment;
  check(comment <> nil, 'comment is nil');
  check(comment.length = Length(Data), 'wrong length');
end;

procedure TTestDOM2Methods.basic_cloneNode_ProcessingInstruction;
begin
  pci := doc.createProcessingInstruction('target','data');
  node := pci.cloneNode(True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node, pci), 'target and source are the same');
  check(node.parentNode = nil, 'parent is nil');
  check(node.nodeName = 'target', 'wrong nodeName');
  check(node.nodeValue = 'data', 'wrong nodeValue');
end;

procedure TTestDOM2Methods.basic_importNode_AttributeNode;
begin
  attr := doc.createAttribute('attr');
  doc.documentElement.setAttributeNode(attr);
  node := doc0.importNode(attr,True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,attr), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeName = 'attr', 'wrong nodeName');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType');

  // the source node is not altered or removed from the original document;
  // this method creates a new copy of the source node
  attr := doc.documentElement.getAttributeNode('attr');
  check(attr <> nil, 'attr was removed');

  attr := node as IDOMAttr;
  check(attr <> nil, 'attr is nil');
  check(attr.ownerElement = nil, 'ownerElement is not nil');
  check(attr.specified, 'attribute is not specified');
end;

procedure TTestDOM2Methods.basic_importNode_AttributeNodeNS;
begin
  attr := doc.createAttributeNS('ABC','abc:attr');
  doc.documentElement.setAttributeNodeNS(attr);
  node := doc0.importNode(attr,True);

  // check imported node
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,attr), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeName = 'abc:attr', 'wrong nodeName');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType');

  check(node.prefix = 'abc', 'wrong prefix - '+node.prefix);
  check(node.localName = 'attr', 'wrong localName');
  check(node.namespaceURI = 'ABC', 'wrong namespaceURI');

  // the source node is not altered or removed from the original document;
  // this method creates a new copy of the source node
  attr := doc.documentElement.getAttributeNodeNS('ABC','attr');
  check(attr <> nil, 'attr was removed');

  // check special properties of the node
  attr := node as IDOMAttr;
  check(attr <> nil, 'attr is nil');
  check(attr.ownerElement = nil, 'ownerElement is not nil');
  check(attr.specified, 'attribute is not specified');
end;

procedure TTestDOM2Methods.basic_importNode_DocumentFragment_deep;
const n = 10;
var i: integer;
begin
  docfrag := doc.createDocumentFragment;
  for i := 0 to n-1 do begin
    elem := doc.createElement('elem');
    docfrag.appendChild(elem);
  end;

  node := doc0.importNode(docfrag,True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,docfrag), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = DOCUMENT_FRAGMENT_NODE, 'wrong nodeType');
  check(node.hasChildNodes, 'childNodes are not carried over');

  // the source node is not altered or removed from the original document;
  // this method creates a new copy of the source node
  check(docfrag.hasChildNodes, 'node was altered');
end;

procedure TTestDOM2Methods.basic_importNode_DocumentFragment_flat;
const n = 10;
var i: integer;
begin
  docfrag := doc.createDocumentFragment;
  for i := 0 to n-1 do begin
    elem := doc.createElement('elem');
    docfrag.appendChild(elem);
  end;

  node := doc0.importNode(docfrag,False);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,docfrag), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = DOCUMENT_FRAGMENT_NODE, 'wrong nodeType');
  check(not node.hasChildNodes, 'childNodes are carried over');

  // the source node is not altered or removed from the original document;
  // this method creates a new copy of the source node
  check(docfrag.hasChildNodes, 'node was altered');
end;

procedure TTestDOM2Methods.basic_importNode_AttributeNode_on_element;
begin
  attr := doc.createAttribute('attr');
  attr.value := 'attr-value';
  check(attr.specified, 'attribute is not specified (I)');
  elem := doc.createElement('elem');
  elem.setAttributeNode(attr);

  node := doc0.importNode(elem, True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,elem), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(node.hasAttributes, 'elem has no attributes');

  attr := node.attributes.namedItem['attr'] as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  check(attr.value = 'attr-value', 'wrong value');
  check(attr.specified, 'attribute is not specified (II)');
end;

procedure TTestDOM2Methods.basic_importNode_AttributeNodeNS_on_element;
begin
  attr := doc.createAttributeNS('ABC','abc:attr');
  attr.value := 'attr-value';
  check(attr.specified, 'attribute is not specified (I)');
  elem := doc.createElementNS('DEF','def:elem');
  elem.setAttributeNodeNS(attr);

  node := doc0.importNode(elem, True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,elem), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  check(node.hasAttributes, 'elem has no attributes');

  attr := node.attributes.getNamedItemNS('ABC','attr') as IDOMAttr;
  check(attr <> nil, 'attribute is nil');
  check(attr.value = 'attr-value', 'wrong value');
  check(attr.specified, 'attribute is not specified (II)');
  check(attr.localName = 'attr', 'localName is wrong');
  check(attr.namespaceURI = 'ABC', 'wrong namespaceURI');
  check(attr.prefix = 'abc', 'wrong prefix');
end;

procedure TTestDOM2Methods.basic_importNode_ProcessingInstruction;
begin
  pci := doc.createProcessingInstruction('target','data');

  node := doc0.importNode(pci,True);
  // check imported node
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,pci), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = PROCESSING_INSTRUCTION_NODE, 'wrong nodeType');

  pci := node as IDOMProcessingInstruction;
  check(pci <> nil, 'ProcessingInstruction is nil');
  check(pci.target = 'target', 'wrong target');
  check(pci.data = 'data', 'wrong data');
end;

procedure TTestDOM2Methods.basic_importNode_TextNode;
begin
  text := doc.createTextNode(Data);

  node := doc0.importNode(text,True);
  // check imported node
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,pci), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = TEXT_NODE, 'wrong nodeType');

  text := node as IDOMText;
  check(text <> nil, 'TextNode is nil');
  check(text.data = Data, 'wrong data');
  check(text.length = Length(Data), 'wrong data');
end;

procedure TTestDOM2Methods.basic_importNode_CDataSection;
begin
  cdata := doc.createCDataSection(Data);

  node := doc0.importNode(cdata,True);
  // check imported node
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,pci), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = CDATA_SECTION_NODE, 'wrong nodeType');

  cdata := node as IDOMCDataSection;
  check(cdata <> nil, 'CDataSection is nil');
  check(cdata.data = Data, 'wrong data');
  check(cdata.length = Length(Data), 'wrong data');
end;

procedure TTestDOM2Methods.basic_importNode_CommentNode;
begin
  comment := doc.createComment(Data);

  node := doc0.importNode(comment,True);
  // check imported node
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,pci), 'target and source are the same');
  check(node.parentNode = nil, 'parent is not nil');
  check(MyIsSameNode(node.ownerDocument,doc0), 'wrong ownerDocument');
  check(node.nodeType = COMMENT_NODE, 'wrong nodeType');

  comment := node as IDOMComment;
  check(comment <> nil, 'comment is nil');
  check(comment.data = Data, 'wrong data');
  check(comment.length = Length(Data), 'wrong data');
end;

procedure TTestDOM2Methods.ext_importNode_AttributeNode_default_on_element;
const
  xmlstr = xmldecl+
           '<!DOCTYPE test ['+
           '<!ELEMENT test (#PCDATA)>'+
           '<!ATTLIST test defattr CDATA "defvalue">'+
           ']>'+
           '<test/>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  attr := doc.documentElement.getAttributeNode('defattr');
  check(not attr.specified, 'attribute is specified but it''s a default attribute');

  node := doc0.importNode(doc.documentElement,True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,doc.documentElement), 'target and source are the same');

  // default attributes are not copied !
  check(not node.hasAttributes, 'node has attributes');
end;

procedure TTestDOM2Methods.ext_importNode_AttributeNode_default;
const
  xmlstr = xmldecl+
           '<!DOCTYPE test ['+
           '<!ELEMENT test (#PCDATA)>'+
           '<!ATTLIST test defattr CDATA "defvalue">'+
           ']>'+
           '<test/>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  attr := doc.documentElement.getAttributeNode('defattr');
  check(not attr.specified, 'attribute is specified but it''s a default attribute');

  node := doc0.importNode(attr,True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,attr), 'target and source are the same');

  attr := node as IDOMAttr;
  check(attr.specified, 'attribute is not specified');
end;

procedure TTestDOM2Methods.ext_importNode_AttributeNodeNS_default;
const
  xmlstr = xmldecl+
           '<!DOCTYPE test ['+
           '<!ELEMENT test (#PCDATA)>'+
           '<!ATTLIST test xmlns:abc CDATA "ABC">'+
           '<!ATTLIST test abc:defattr CDATA "defvalue">'+
           ']>'+
           '<test/>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  attr := doc.documentElement.getAttributeNodeNS('ABC','defattr');
  check(not attr.specified, 'attribute is specified but it''s a default attribute');
  check(attr.prefix = 'abc', 'wrong prefix');
  check(attr.localName = 'defattr', 'wrong localName');
  check(attr.namespaceURI = 'ABC', 'wrong namespaceURI');

  node := doc0.importNode(attr,True);
  check(node <> nil, 'node is nil');
  check(not MyIsSameNode(node,attr), 'target and source are the same');

  attr := node as IDOMAttr;
  check(attr.specified, 'attribute is not specified');
  check(attr.localName = 'defattr', 'wrong localName');
  check(attr.namespaceURI = 'ABC', 'wrong namespaceURI');
  check(attr.prefix = 'abc', 'wrong prefix');
end;
procedure TTestDOM2Methods.ext_attribute_default_removeNamedItemNS;
const
  xmlstr = xmldecl+
           '<!DOCTYPE test ['+
           '<!ELEMENT test (#PCDATA)>'+
           '<!ATTLIST test xmlns:def CDATA "DEF">'+
           '<!ATTLIST test def:attr  CDATA "defval">'+
           ']>'+
           '<test/>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  nnmap := doc.documentElement.attributes;
  check(nnmap <> nil, 'NamedNodeMap is nil');
  check(nnmap.length = 2, 'wrong length');

  // check if default attribute exists
  node := nnmap.getNamedItemNS('DEF','attr');
  check(node <> nil, 'node is nil - namedItem not found (I)');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType (II)');
  check(node.nodeValue = 'defval', 'wrong nodeValue (III)');

  // modify default attribute
  attr := doc.createAttributeNS('DEF','def:attr');
  attr.value := 'newval';
  nnmap.setNamedItemNS(attr);


  // this does the same as the code above !
  // node.nodeValue := 'newval';

  // check if modified attribute exists
  node := nnmap.getNamedItemNS('DEF','attr');
  check(node <> nil, 'node is nil - namedItem not found (IV)');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType (V)');
  check(node.nodeValue = 'newval', 'wrong nodeValue (VI)');


  // remove modified value
  node := nnmap.removeNamedItemNS('DEF','attr');
  check(node <> nil, 'removed item is nil - does not exist ?');


  // check if default attribute exists
  node := nnmap.getNamedItemNS('DEF','attr');
  check(node <> nil, 'node is nil - namedItem not found (VII)');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType (VIII)');
  check(node.nodeValue = 'defval', 'wrong nodeValue (IX)');


  // remove default value
  node := nnmap.removeNamedItemNS('DEF','attr');
  check(node <> nil, 'removed item is nil - does not exist ?');


  // check if default attribute exists
  node := nnmap.getNamedItemNS('DEF','attr');
  check(node <> nil, 'node is nil - namedItem not found (X)');
  check(node.nodeType = ATTRIBUTE_NODE, 'wrong nodeType (XI)');
  check(node.nodeValue = 'defval', 'wrong nodeValue (XII)');

end;

procedure TTestDOM2Methods.ext_attribute_default_modify;
const
  xmlstr = xmldecl+
           '<!DOCTYPE test ['+
           '<!ELEMENT test (#PCDATA)>'+
           '<!ATTLIST test xmlns:def CDATA "DEF">'+
           '<!ATTLIST test def:attr  CDATA "defval">'+
           ']>'+
           '<test/>';
begin
  check((doc as IDOMPersist).loadxml(xmlstr), 'parse error');
  attr := doc.documentElement.getAttributeNodeNS('DEF','attr');
  check(attr <> nil, 'there''s no attribute def:attr');
  check(attr.value = 'defval', 'wrong value');
  check(not attr.specified, 'default attribute is specified');
  check(MyIsSameNode(attr.ownerElement,doc.documentElement), 'wrong ownerElement');
  check(attr.namespaceURI = 'DEF', 'wrong namespaceURI');
  check(attr.prefix = 'def', 'wrong prefix');
  attr.value := 'newval';
  check(attr.specified, 'attribute was modified but is not specified');
  check(attr.prefix = 'def', 'wrong prefix');
  check(attr.namespaceURI = 'DEF', 'wrong namespaceURI');
  check(attr.value = 'newval', 'wrong value');
end;

procedure TTestDOM2Methods.unknown_normalize_mix;
const n = 10;
var i: integer;
begin
  // generate some test nodes
  for i := 0 to n-1 do begin
    Text := doc.createTextNode(Data + IntToStr(i));
    doc.documentElement.appendChild(Text);
    elem := doc.createElement('elem' + IntToStr(i));
    doc.documentElement.appendChild(elem);
  end;

  // check test nodes
  node := doc.documentElement.firstChild;
  for i := 0 to n-1 do begin
    check(node <> nil, 'node is nil');
    check(node.nodeType = TEXT_NODE, 'wrong nodeType');
    node := node.nextSibling;
    check(node <> nil, 'node is nil');
    check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
    node := node.nextSibling;
  end;

  doc.documentElement.normalize;

  // check test nodes
  node := doc.documentElement.firstChild;
  for i := 0 to n-1 do begin
    check(node <> nil, 'node is nil');
    check(node.nodeType = TEXT_NODE, 'wrong nodeType');
    node := node.nextSibling;
    check(node <> nil, 'node is nil');
    check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
    node := node.nextSibling;
  end;
end;

procedure TTestDOM2Methods.unknown_normalize_emptyTextNodes;
begin
  text := doc.createTextNode('');
  doc.documentElement.appendChild(text);
  node := doc.documentElement.firstChild;
  check(node <> nil, 'node is nil');
  check(node.nodeType = TEXT_NODE, 'wrong nodeType');
  check(node.nodeValue = '', 'wrong nodeValue');
  doc.documentElement.normalize;
  node := doc.documentElement.firstChild;
  check(node = nil, 'empty text node not removed by normalize');
end;

procedure TTestDOM2Methods.unknown_normalize_flat;
const n = 10;
var i: integer; temp: IDOMNode;
begin
  // generate some test nodes
  node := doc.documentElement;
  for i := 0 to n-1 do begin
    elem := doc.createElement('elem');
    attr := doc.createAttribute('empty-attr');
    elem.setAttributeNode(attr);
    text := doc.createTextNode('test'+IntToStr(i)+' ... ');
    elem.appendChild(text);
    // we have to use a trick to generate adjacent text nodes in libxml
    // because libxml automatically merges a text to the previous node if the
    // previous node is a text node
    temp := doc.createElement('remove-me');
    elem.appendChild(temp);
    text := doc.createTextNode('mehr'+IntToStr(i)+' ... ');
    elem.appendChild(text);
    elem.removeChild(temp);
    node := node.appendChild(elem);
  end;

  // check the test node
  elem := doc.documentElement.firstChild as IDOMElement;
  for i := 0 to n-1 do begin
    node := elem.firstChild;
    check(node <> nil, 'node is nil');
    check(node.nodeType = TEXT_NODE, 'wrong nodeType (a) '+IntToStr(i));
    check(node.nodeValue = 'test'+IntToStr(i)+' ... ', 'wrong nodeValue');
    node := node.nextSibling;
    check(node <> nil, 'node is nil');
    check(node.nodeType = TEXT_NODE, 'wrong nodeType (b) '+IntToStr(i));
    check(node.nodeValue = 'mehr'+IntToStr(i)+' ... ', 'wrong nodeValue');
    elem := node.nextSibling as IDOMElement;
  end;


  node := doc.documentElement.firstChild;
  node.normalize;

  // check if normalize works flat
  check(node <> nil, 'node is nil');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
  node := node.firstChild;
  check(node <> nil, 'node is nil');
  check(node.nodeType = TEXT_NODE, 'wrong nodeType');
  check(node.nodeValue = 'test0 ... mehr0 ... ', 'wrong nodeValue - normalize does not merge adjacent text nodes');
  node := node.nextSibling;
  check(node <> nil, 'node is nil');
  check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
end;

procedure TTestDOM2Methods.unknown_normalize_deep;
const n = 10;
var i: integer; temp: IDOMNode;
begin
  // generate some test nodes
  node := doc.documentElement;
  for i := 0 to n-1 do begin
    elem := doc.createElement('elem');
    attr := doc.createAttribute('empty-attr');
    elem.setAttributeNode(attr);
    text := doc.createTextNode('test'+IntToStr(i)+' ... ');
    elem.appendChild(text);
    // we have to use a trick to generate adjacent text nodes in libxml
    // because libxml automatically merges a text to the previous node if the
    // previous node is a text node
    temp := doc.createElement('remove-me');
    elem.appendChild(temp);
    text := doc.createTextNode('mehr'+IntToStr(i)+' ... ');
    elem.appendChild(text);
    elem.removeChild(temp);
    node := node.appendChild(elem);
  end;

  // check the test node
  elem := doc.documentElement.firstChild as IDOMElement;
  for i := 0 to n-1 do begin
    node := elem.firstChild;
    check(node <> nil, 'node is nil');
    check(node.nodeType = TEXT_NODE, 'wrong nodeType (a) '+IntToStr(i));
    check(node.nodeValue = 'test'+IntToStr(i)+' ... ', 'wrong nodeValue');
    node := node.nextSibling;
    check(node <> nil, 'node is nil');
    check(node.nodeType = TEXT_NODE, 'wrong nodeType (b) '+IntToStr(i));
    check(node.nodeValue = 'mehr'+IntToStr(i)+' ... ', 'wrong nodeValue');
    elem := node.nextSibling as IDOMElement;
  end;


  node := doc.documentElement.firstChild;
  node.normalize;

  // check if normalize works deep
  for i := 0 to n-1 do begin
    check(node <> nil, 'node is nil');
    check(node.nodeType = ELEMENT_NODE, 'wrong nodeType');
    node := node.firstChild;
    check(node <> nil, 'node is nil');
    check(node.nodeType = TEXT_NODE, 'wrong nodeType');
    check(node.nodeValue = 'test'+IntToStr(i)+' ... mehr'+IntToStr(i)+' ... ', 'wrong nodeValue - normalize does not merge adjacent text nodes');
    node := node.nextSibling;
  end;
end;

initialization
  datapath := getDataPath;
  {$ifdef mswindows}
  CoInitialize(nil);
  {$endif}
  {$ifdef linux}
  ;
  {$endif}
end.
