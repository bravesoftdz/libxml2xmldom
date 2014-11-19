unit domSetup;

interface

uses
  fpcunit,
  idom2;

const
  illegalChars: array[0..25] of widechar =
    ('{', '}', '~', '''', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')',
    '+', '=', '[', ']', '\', '/', ';', #96, '<', '>', ',', '"');

type

  IDomSetup = interface
  ['{10D5ACC8-EE97-4D35-8A9E-5746F3D20B35}']
    function getVendorID: string;
    function getDocumentBuilder: IDomDocumentBuilder;
  end;

function createDomSetupTest(const vendorID: string; test: TTest): TTest;

  (*
   * provides a reference to the current IDomSetup. Use it within the Dom test
   * cases to get the current VendorID and current documentBuilder.
  *)
function getCurrentDomSetup: IDomSetup;

implementation

uses
  testdecorator, testregistry, Classes;

type

  (*
   * Test decorator that will initialize the DOM for a specific VendorID
  *)
  TInterfacedObjectMixIn = class(TInterfacedObject) end;
  { TDomSetup }
  TDomSetup = class(TTestSetup, IDomSetup)
  private
    fVendorID: string;
    fDocumentBuilder: IDomDocumentBuilder;
    fRefCounter: TInterfacedObjectMixIn;
    { implement methods of IUnknown }
    function QueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} iid : tguid;out obj) : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    function _AddRef : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    function _Release : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
  public
    constructor Create(const vendorID: string; test: TTest);
    destructor Destroy; override;

    procedure OneTimeSetup; override;
    procedure OneTimeTearDown; override;

    (* IDomSetup methods *)
    function getVendorID: string;
    function getDocumentBuilder: IDomDocumentBuilder;
  end;

var
  (* reference to the current DomSetup *)
  gCurrentDomSetup: IDomSetup;
  gDomSetups: TInterfaceList;

function TDomSetup.QueryInterface(constref iid: tguid; out obj): longint;
  stdcall;
begin
  Result := fRefCounter.QueryInterface(iid, obj);
end;

function TDomSetup._AddRef: longint; stdcall;
begin
  Result := fRefCounter._AddRef;
end;

function TDomSetup._Release: longint; stdcall;
begin
  Result := fRefCounter._Release;
  if Result=0 then
    self.destroy;
end;

constructor TDomSetup.Create(const vendorID: string; test: TTest);
begin
  inherited Create(test);
  fVendorID := vendorID;
  fRefCounter:= TInterfacedObjectMixIn.Create;
end;

destructor TDomSetup.Destroy;
begin
  fDocumentBuilder := nil;
end;

procedure TDomSetup.OneTimeSetup;
begin
  {get DocumentBuilder on demand in setup so exceptions will be caught by DUnit}
  if fDocumentBuilder = nil then begin
    fDocumentBuilder := getDocumentBuilderFactory(fVendorID).newDocumentBuilder;
  end;

  {register this DomSetup as the current one}
  gCurrentDomSetup := self;
end;

procedure TDomSetup.OneTimeTearDown;
begin
  gCurrentDomSetup := nil;
end;

function TDomSetup.getVendorID: string;
begin
  Result := fVendorID;
end;

function TDomSetup.getDocumentBuilder: IDomDocumentBuilder;
begin
  Result := fDocumentBuilder;
end;

(* creator for DomSetup *)
function createDomSetupTest(const vendorID: string; test: TTest): TTest;
begin
  Result := TDomSetup.Create(vendorID, test);
  gDomSetups.Add(Result as IDomSetup);
end;


(* returns the current dom setup *)
function getCurrentDomSetup: IDomSetup;
begin
  Result := gCurrentDomSetup;
end;

initialization
  gDomSetups := TInterfaceList.Create;
finalization
  gDomSetups.Free;

end.
