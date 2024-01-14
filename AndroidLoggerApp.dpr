program AndroidLoggerApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  AndroudLoggerApp.Main in 'AndroudLoggerApp.Main.pas' {frmLogDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogDemo, frmLogDemo);
  Application.Run;
end.
