unit Main;

{$MODE Delphi}

interface

uses
  idom2;

implementation

uses
  SysUtils,
  fpcunit,
  testregistry,
  domSetup,
  libxmldom,
  {$ifdef MSWINDOWS}
  msxml_impl,
  {$endif}

  (* add new tests to uses class *)

  XPTest_idom2_TestDOM2Methods,
  XPTest_idom2_TestDomExceptions,
  XPTest_idom2_TestMemoryLeaks,
  XPTest_idom2_TestXPath,
  XPTest_idom2_TestXSLT,
  XPTest_idom2_TestPersist,
  DomImplementationTests,
  DomDocumentTests;

(*
 * Returns a TestSuite made up of all individual test suits. This will be used
 * for registering all tests for every Dom VendorID.
 * If a new test suite is created it should be added to this suite
 *
 * @param name the name of the All Test suite
*)
function getAllTests(const Name: string): TTest;
var
  allTestSuite: TTestSuite;
begin
  allTestSuite := TTestSuite.Create(Name);

  (* add all test suits to the allTestSuite *)

  allTestSuite.AddTest(TTestDOM2Methods.Suite);
  allTestSuite.AddTest(TTestDomExceptions.Suite);
  allTestSuite.AddTest(TTestMemoryLeaks.Suite);
  allTestSuite.AddTest(TTestXPath.Suite);
  allTestSuite.AddTest(TTestXSLT.Suite);
  allTestSuite.AddTest(TTestPersist.Suite);
  allTestSuite.AddTest(TDomImplementationFundamentalTests.Suite);
  allTestSuite.AddTest(TDomDocumentFundamentalTests.Suite);

  Result := allTestSuite;
end;

initialization
  (*
   * for every DomVendorID add a new line. This make sure that all tests
   * will be run for every Dom Implementation (specified by VendorID)
  *)

  {$ifdef MSWINDOWS}
  //if not FindCmdLineSwitch('no_msxml', true)
  //   then
       RegisterTest(MSXML2Rental, DomSetup.createDomSetupTest(MSXML2Rental, getAllTests('Ms-DOM Rental')));
  {$endif}

  {remove comments to add testing of the Appartment Free Ms version }
  //  TestFramework.RegisterTest(
  //      DomSetup.createDomSetupTest(MSXML2Free, getAllTests('Ms-DOM Free')));

  RegisterTest(SLIBXML, DomSetup.createDomSetupTest(SLIBXML, getAllTests('Lib XML 2')));
end.
