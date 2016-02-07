unit xmldom_ext;

interface

(*
 * Interface specifications for extensions to Dom level 2.
 *
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Initial Developers of the Original Code are:

 *   - Martijn Brinkers (m.brinkers@pobox.com)
 *   - Uwe Fechner (ufechner@csi.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
*)

uses xmldom, classes;

type

  { IDomNodeCompare }

  // this interfaces implements the dom3 method IsSameNode
  // it is neccessary to use it with libxml2, because there can be
  // several interfaces pointing to the same node

  IDomNodeCompare = interface
    ['{ED63440C-6A94-4267-89A9-E093247F10F8}']
    function IsSameNode(node: IDomNode): boolean;
  end;

  { IDomNodeExt }

  // this interface is similar to the interface IDomNodeEx from Borland,
  // but not the same, therefore a slightly different name is used
  // it provides methods for xslt transformation (transformNode)
  // for accessing the text-value of an element (similar to textcontent in dom3)
  // and for obtaining the string-value of a node (property xml)

  IDomNodeEx2 = interface(IDomNode)
    ['{1B41AE3F-6365-41FC-AFDD-26BC143F9C0F}']
    procedure RegisterNS(const prefix, URI: DomString);
  end;

  { IDomNodeListExt }

  // this interface is similar to the interface IDomNodeExt
  // and is using for serialization of nodelists

  IDomNodeListExt = interface(IDomNodeList)
    ['{1B41AE3F-6365-41FC-AFDD-26BC143F9C0F}']
    { Property Acessors }
    function get_xml: DomString;
    { Methods }
    { Properties }
    property xml: DomString read get_xml;
  end;

  {IDomOutputOptions}

  // this interface enables using the output-options, provided by libxml2
  // it will be replaced by dom3 methods in the future

  IDomOutputOptions = interface
    ['{B2ECC3F1-CC9B-4445-85C6-3D62638F7835}']
    { Property Acessors }
    function get_prettyPrint: boolean;
    function get_encoding: DomString;
    function get_parsedEncoding: DomString;
    function get_compressionLevel: integer;
    procedure set_prettyPrint(prettyPrint: boolean);
    procedure set_encoding(encoding: DomString);
    procedure set_compressionLevel(compressionLevel: integer);
    { methods }
    { Properties }
    property prettyPrint: boolean read get_prettyPrint write set_prettyPrint;
    property encoding: DomString read get_encoding write set_encoding;
    property parsedEncoding: DomString read get_parsedEncoding;
    property compressionLevel: integer read get_compressionLevel write set_compressionLevel;
  end;

  {IDomDebug}

  // this interface enables it, to get the count of currently existing documents
  // for debugging purposes

  IDomDebug = interface
  ['{D5DE14B0-C454-4E75-B6CE-4E8C07FAC9BA}']
    { Property Acessors }
    function get_doccount: integer;
    procedure set_doccount(doccount: integer);
    { Properties }
    property doccount: integer read get_doccount write set_doccount;
  end;

  {IDOMDocumentEx}
  // Proivdes validation functions like those found in PHPs DOMDocument
  // relaxNG and xmlschema are to be stored and applied after loading a document.
  IDOMDocumentEx = interface
    ['{6CA1B4C1-D02F-4980-8D54-80784B5157A8}']
    function get_relaxNG: IDOMDocument; safecall;
    function get_xmlschema: IDOMDocument; safecall;
    procedure set_xmlschema(source: IDOMDocument); safecall;
    procedure set_relaxNG(source: IDOMDocument); safecall;
    function schemaValidate (filename: OleVariant; flags: LongInt): WordBool; safecall;
    function schemaValidateSource (source: DOMString; flags: LongInt): WordBool; safecall;
    function relaxNGValidate (filename: OleVariant): WordBool; safecall;
    function relaxNGValidateSource (source: DOMString): WordBool; safecall;
    property relaxNG: IDOMDocument read get_relaxNG write set_relaxNG;
    property xmlschema: IDOMDocument read get_xmlschema write set_xmlschema;
  end;

  const // see http://stackoverflow.com/questions/15948847/injecting-xml-schema-defaults-into-documents-with-php
    SCHEMA_VALIDATE_FLAGS_INJECT_DEFAULTS = 1 shl 0; // = XML_SCHEMA_VAL_VC_I_CREATE
// 1 shl 1 = XML_SCHEMA_VAL_XSI_ASSEMBLE

type
  IURIResolver = interface
    ['{2092A16A-33AD-48A9-B3A3-57C253F7AE18}']
    function resolveURI(URI: string): TStream;
  end;

procedure registerNS(doc: IDOMDocument; prefix, namespaceuri: DOMString);
procedure setXSDSchema(doc, xsd: IDOMDocument);
procedure enableScriptExtensions(doc: IDOMDocument);

var
  GlobalURIResolver: IURIResolver;

implementation

uses SysUtils, msxmldom, msxml, ComObj;

type

// *********************************************************************//
// Interface: IXMLDOMSchemaCollection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {373984C8-B845-449B-91E7-45AC83036ADE}
// *********************************************************************//
  IXMLDOMSchemaCollection = interface(IDispatch)
    ['{373984C8-B845-449B-91E7-45AC83036ADE}']
    procedure add(const namespaceURI: WideString; var_: OleVariant); safecall;
    function get(const namespaceURI: WideString): IXMLDOMNode; safecall;
    procedure remove(const namespaceURI: WideString); safecall;
    function Get_length: Integer; safecall;
    function Get_namespaceURI(index: Integer): WideString; safecall;
    procedure addCollection(const otherCollection: IXMLDOMSchemaCollection); safecall;
    function Get__newEnum: IUnknown; safecall;
    property length: Integer read Get_length;
    property namespaceURI[index: Integer]: WideString read Get_namespaceURI; default;
    property _newEnum: IUnknown read Get__newEnum;
  end;

// *********************************************************************//
// Interface: IXMLDOMDocument2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2933BF95-7B36-11D2-B20E-00C04F983E60}
// *********************************************************************//
  IXMLDOMDocument2 = interface(IXMLDOMDocument)
    ['{2933BF95-7B36-11D2-B20E-00C04F983E60}']
    function Get_namespaces: IXMLDOMSchemaCollection; safecall;
    function Get_schemas: OleVariant; safecall;
    procedure _Set_schemas(otherCollection: OleVariant); safecall;
    function validate: IXMLDOMParseError; safecall;
    procedure setProperty(const name: WideString; value: OleVariant); safecall;
    function getProperty(const name: WideString): OleVariant; safecall;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  end;

procedure registerNS(doc: IDOMDocument; prefix, namespaceuri: DOMString);
var
  msxmlnodewrapper: IXMLDOMNodeRef;
  msxmldoc : IXMLDOMDocument2;
  oldNameSpaces: AnsiString;
  extdomnode: IDomNodeEx2;
begin
  doc.QueryInterface(IXMLDOMNodeRef, msxmlnodewrapper);
  if Assigned(msxmlnodewrapper) then
  begin
    msxmldoc := msxmlnodewrapper.GetXMLDOMNode as IXMLDomDocument2;
    oldNameSpaces := msxmldoc.getProperty('SelectionNamespaces');
    msxmldoc.setProperty(
          'SelectionNamespaces',
          oldNamespaces + ' xmlns:'+prefix+'=''' + namespaceuri + '''');
    Exit;
  end;
  doc.QueryInterface(IDomNodeEx2, extdomnode);
  if Assigned(extdomnode) then
  begin
    (doc.documentElement as IDomNodeEx2).RegisterNS(prefix, namespaceuri);
    Exit;
  end;
end;

procedure setXSDSchema(doc, xsd: IDOMDocument);
var
  msxmlnodewrapper: IXMLDOMNodeRef;
  msxmldoc, msxmlxsd: IXMLDOMDocument2;
  sc: IXMLDOMSchemaCollection;
  docEx: IDOMDocumentEx;
begin
  doc.QueryInterface(IXMLDOMNodeRef, msxmlnodewrapper);
  if Assigned(msxmlnodewrapper) then
  begin
    msxmldoc := msxmlnodewrapper.GetXMLDOMNode as IXMLDomDocument2;
    xsd.QueryInterface(IXMLDOMNodeRef, msxmlnodewrapper);
    msxmlxsd := msxmlnodewrapper.GetXMLDOMNode as IXMLDomDocument2;
    sc := CreateOleObject('Msxml2.XMLSchemaCache.6.0') as IXMLDOMSchemaCollection;
    sc.Add('', msxmlxsd);
    msxmldoc.schemas := OleVariant(sc);
    exit;
  end;
  doc.QueryInterface(IDOMDocumentEx, docEx);
  if Assigned(docEx) then
  begin
    docEx.xmlschema := xsd;
    Exit;
  end;
  raise DOMException.Create('XSD Schema validation not implemented');
end;

procedure enableScriptExtensions(doc: IDOMDocument);
var
  msxmlnodewrapper: IXMLDOMNodeRef;
  msxmldoc: IXMLDOMDocument2;
begin
  doc.QueryInterface(IXMLDOMNodeRef, msxmlnodewrapper);
  if Assigned(msxmlnodewrapper) then
  begin
    msxmldoc := msxmlnodewrapper.GetXMLDOMNode as IXMLDomDocument2;
    msxmldoc.setProperty('AllowXsltScript', true);
  end;
end;

end.
