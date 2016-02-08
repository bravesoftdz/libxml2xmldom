program XPTestSuite_idom2;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,
  Forms,
  Interfaces,
  testregistry,
  TestFramework,
  GuiTestRunner,
  Main;

{$R *.res}

begin
  Application.Title:='IDOM MSXML LibXML2 GUI';
  Application.Initialize;
  RunRegisteredTests;
end.

