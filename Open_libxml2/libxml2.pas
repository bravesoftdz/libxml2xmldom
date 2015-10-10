unit libxml2;
{
  ------------------------------------------------------------------------------
  This unit collects all the translated headers of libxml2 (aka gnome-xml).
  2001 (C) Petr Kozelka <pkozelka@email.cz>
  ------------------------------------------------------------------------------
  See also:
    http://www.xmlsoft.org  - the libxml2 homepage
    http://kozelka.hyperlink.cz  - my homepage
}

interface

uses
{$IFDEF WIN32}
  Windows,
{$ENDIF}
{$IFDEF LINUX}
  libc,
{$ENDIF}
  iconv;
const
{$IFDEF WIN32}
  LIBXML2_SO = 'libxml2.dll';
{$ENDIF}
{$IFDEF WIN64}
  LIBXML2_SO = 'libxml2.dll';
{$ENDIF}
{$IFDEF LINUX}
  LIBXML2_SO = 'libxml2.so';
{$ENDIF}

{$IFDEF VER140}
{$ALIGN 4}
{$ENDIF}
{$MINENUMSIZE 4}
{$ASSERTIONS OFF}

type
  DWORD = Cardinal;
  PLongint = ^Longint;
  PByte = ^Byte;
  PPAnsiChar = ^PAnsiChar;
  PLibXml2File = pointer; //placeholder for 'FILE *' C-type

{$DEFINE LIBXML_THREAD_ALLOC_ENABLED}
{$DEFINE LIBXML_THREAD_ENABLED}
{$DEFINE LIBXML_HTML_ENABLED}
{$DEFINE LIBXML_DOCB_ENABLED}

{TODO: $I libxml_xmlversion.inc}
{$I libxml_xmlwin32version.inc}
{$I libxml_xmlmemory.inc}
{$I libxml_tree.inc}
{$I libxml_encoding.inc}
{$I libxml_xmlIO.inc}
{$I libxml_hash.inc}
{$I libxml_dict.inc}
{$I libxml_entities.inc}
{$I libxml_list.inc}
{$I libxml_valid.inc}
{$I libxml_parser.inc}
{$I libxml_SAX.inc}
{$I libxml_xpath.inc}
{$I libxml_xpathInternals.inc}
{$I libxml_xpointer.inc}
{$I libxml_xmlerror.inc}
{$I libxml_xlink.inc}
{$I libxml_xinclude.inc}
{$I libxml_debugXML.inc}
{$I libxml_nanoftp.inc}
{$I libxml_nanohttp.inc}
{$I libxml_uri.inc}
{$I libxml_HTMLparser.inc}
{$I libxml_HTMLtree.inc}
{$I libxml_parserInternals.inc}
{$I libxml_DOCBparser.inc}
{$I libxml_catalog.inc}
{$I libxml_globals.inc}
{$I libxml_threads.inc}
{$I libxml_c14n.inc}
{$I libxml_xmlschemas.inc}
{$I libxml_relaxng.inc}

{$IFDEF WIN32}
{ this function should release memory using the same mem.manager that libxml2
  uses for allocating it. Unfortunately it doesn't work...
}
{$ENDIF}

// functions that reference symbols defined later - by header file:

// tree.h
function  xmlSaveFileTo(buf: xmlOutputBufferPtr; cur: xmlDocPtr; encoding: PAnsiChar): Longint; cdecl; external LIBXML2_SO;
function  xmlSaveFormatFileTo(buf: xmlOutputBufferPtr; cur: xmlDocPtr; encoding: PAnsiChar; format: Longint): Longint; cdecl; external LIBXML2_SO;
procedure xmlNodeDumpOutput(buf: xmlOutputBufferPtr; doc: xmlDocPtr; cur: xmlNodePtr; level: Longint; format: Longint; encoding: PAnsiChar); cdecl; external LIBXML2_SO;

// xmlIO.h
function xmlNoNetExternalEntityLoader(URL: PAnsiChar; ID: PAnsiChar; ctxt: xmlParserCtxtPtr): xmlParserInputPtr; cdecl; external LIBXML2_SO;

//
procedure xmlFree(str: PxmlChar);

type
  (**
   * This interface is intended for libxml2 wrappers. It provides a way
   * back - i.e. from the wrapper object to the libxml2 node.
   *)
  ILibXml2Node = interface ['{1D4BD646-0AB9-4810-B4BD-7277FB0CFA30}']
    function  LibXml2NodePtr: xmlNodePtr;
  end;

implementation

uses
  SysUtils;

procedure xmlFree(str: PxmlChar);
begin
  FreeMem(PAnsiChar(str)); //hopefully works under Kylix
end;

// macros from xpath.h

function xmlXPathNodeSetGetLength(ns: xmlNodeSetPtr): Integer;
begin
  if ns = nil then begin
    Result := 0;
  end else begin
    Result := ns^.nodeNr;
  end;
end;

function xmlXPathNodeSetItem(ns: xmlNodeSetPtr; index: Integer): xmlNodePtr;
var
  p: PxmlNodePtr;
begin
  Result := nil;
  if ns = nil then exit;
  if index < 0 then exit;
  if index >= ns^.nodeNr then exit;
  p := ns^.nodeTab;
  Inc(p, index);
  Result := p^;
end;

function xmlXPathNodeSetIsEmpty(ns: xmlNodeSetPtr): Boolean;
begin
  Result := ((ns = nil) or (ns.nodeNr = 0) or (ns.nodeTab = nil));
end;

// macros from parserInternals

procedure SKIP_EOL(var p: PxmlChar);
begin
  if (p^ = #13) then begin
    Inc(p);
    if (p^ = #10) then Inc(p);
  end;
  if (p^ = #10) then begin
    Inc(p);
    if (p^ = #13) then Inc(p);
  end;
end;

procedure MOVETO_ENDTAG(var p: PxmlChar);
begin
{$ifndef VER130} // not Delphi 5
  while ((p^ <> #0) and (p^ <> '>')) do begin
    p := StrNextChar(p);
  end;
{$endif}
end;

procedure MOVETO_STARTTAG(var p: PxmlChar);
begin
{$ifndef VER130} // not Delphi 5
  while ((p^ <> #0) and (p^ <> '<')) do begin
    p := StrNextChar(p);
  end;
{$endif}
end;

// Delphi memory handling
procedure DelphiFreeFunc(ptr: Pointer); cdecl;
begin
  FreeMem(ptr);
end;

function DelphiMallocFunc(size: size_t): Pointer; cdecl;
begin
  Result := AllocMem(size);
end;

function DelphiReallocFunc(ptr: Pointer; size: size_t): Pointer; cdecl;
begin
  Result := ReallocMemory(ptr, size);
end;

function DelphiStrdupFunc(str: PAnsiChar): PAnsiChar; cdecl;
var
  sz: Integer;
begin
  sz := StrLen(str);
  Result := AllocMem(sz + 1);
  Move(str^, Result^, sz);
end;

initialization
  // setup Delphi memory handler
  xmlMemSetup(@DelphiFreeFunc, @DelphiMallocFunc, @DelphiReallocFunc, @DelphiStrdupFunc);

end.

