program FixAndroidLogger;

uses
  System.StartUpCopy,
  FMX.Forms,
  FixAndroudLoggerDemoImpl in 'FixAndroudLoggerDemoImpl.pas' {frmLogDemo},
  FMX.Platform.Logger.Android.Fix in 'FMX.Platform.Logger.Android.Fix.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogDemo, frmLogDemo);
  Application.Run;
end.
