// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program XPTestSuite_idom2;

{x$MODE Delphi}

{.$APPTYPE CONSOLE}

uses
//  TextTestRunner,
  SysUtils,
  LCLIntf, LCLType, LMessages,
  Forms, Interfaces,
  GUITestRunner,
  msxml_impl,
  libxmldom,
  libxslt,
  Main in 'Main.pas',
  XPTest_idom2_Shared in 'XPTest_idom2_Shared.pas',
  XPTest_idom2_TestDOM2Methods in 'XPTest_idom2_TestDOM2Methods.pas',
  XPTest_idom2_TestDomExceptions in 'XPTest_idom2_TestDomExceptions.pas',
  XPTest_idom2_TestMemoryLeaks in 'XPTest_idom2_TestMemoryLeaks.pas',
  XPTest_idom2_TestPersist in 'XPTest_idom2_TestPersist.pas',
  XPTest_idom2_TestXPath in 'XPTest_idom2_TestXPath.pas',
  XPTest_idom2_TestXSLT in 'XPTest_idom2_TestXSLT.pas',
  domSetup in 'domSetup.pas',
  DomDocumentTests in 'contrib\DomDocumentTests.pas',
  DomImplementationTests in 'contrib\DomImplementationTests.pas';

{$ifndef linux}

{$R *.res}
{$endif}

const
  SwitchChars = ['-', '/'];

procedure RunInConsoleMode;
var
  meminfo, memloop, memdelta: cardinal;
  i, iloop:    integer;
//  rxbBehavior: TRunnerExitBehavior;
begin
  try
    try
      {$ifndef linux}
      if not IsConsole then begin
//         Windows.AllocConsole;
      end;
      {$endif}
      writeln('XPTest Suite is started ...');
      writeln;
      writeln;
      for i := 1 to ParamCount do begin
        if not (ParamStr(i)[1] in SwitchChars) then begin
//          RegisterModuleTests(ParamStr(i));
        end;
      end;
      // how to handle errors
      if FindCmdLineSwitch('haltonfailure', SwitchChars, True) then begin
//        rxbBehavior := rxbHaltOnFailures;
      end else if FindCmdLineSwitch('pause', SwitchChars, True) then begin
//        rxbBehavior := rxbPause;
      end else begin
//        rxbBehavior := rxbContinue;
      end;
      // how to loop
      if FindCmdLineSwitch('loop2',  SwitchChars, True) then iloop :=  2
      else
      if FindCmdLineSwitch('loop3',  SwitchChars, True) then iloop :=  3
      else
      if FindCmdLineSwitch('loop5',  SwitchChars, True) then iloop :=  5
      else
      if FindCmdLineSwitch('loop10', SwitchChars, True) then iloop := 10
      else
      if FindCmdLineSwitch('loop15', SwitchChars, True) then iloop := 15
      else
      if FindCmdLineSwitch('loop20', SwitchChars, True) then iloop := 20
      else
      if FindCmdLineSwitch('loop25', SwitchChars, True) then iloop := 25
      else
      if FindCmdLineSwitch('loop50', SwitchChars, True) then iloop := 50
      else
      if FindCmdLineSwitch('loop_infinite', SwitchChars, True) then iloop := MAXINT
      else
         iloop := 1;

      // store memory info
      meminfo := getCurMemory;

      // now loop this test as many times as ...
      for i := 1 to iloop do
        begin
          writeln; writeln; writeln; writeln;
          write  (Format('Start with loop %d in 2,5 seconds...', [i]));
          Sleep(2500);
          writeln; writeln; writeln; writeln;

          memloop := getCurMemory;

//          TextTestRunner.RunRegisteredTests(rxbBehavior);

          // calc mem delta
          memdelta := getCurMemory - meminfo;

          // show info
          writeln; writeln; writeln; writeln;
          writeln(Format('Finished with loop delta %d bytes, overall delta %d bytes', [getCurMemory - memloop, memdelta]));
          writeln;
          write  ('Going on in 5 seconds...');
          if (i < iloop) then Sleep(5000);
          writeln;

          // is break
          if (memdelta > (1024 * 1024 * 64))
             then raise exception.CreateFmt('memory leak exceed maximum of 64MB (%d) after %d loops', [memdelta, i]);

        end;

    except
      on e: Exception do Writeln(Format('%s: %s', [e.ClassName, e.Message]));
    end;
  finally
    {$ifndef linux}
    if not IsConsole then begin
    {$endif}
      writeln;
      write  ('Press <RETURN> to exit.');
      readln;
    {$ifndef linux}
    end;
    {$endif}
  end;
end;

begin
  //if FindCmdLineSwitch('c', SwitchChars, True) then begin
  //  RunInConsoleMode;
  //end else begin
    Application.Initialize;
    Application.CreateForm(TGuiTestRunner, TestRunner);
    Application.Run;
  //end;
end.
