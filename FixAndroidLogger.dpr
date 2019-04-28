program FixAndroidLogger;

uses
  System.StartUpCopy,
  FMX.Forms,
  FixAndroudLoggerDemoImpl in 'FixAndroudLoggerDemoImpl.pas' {Form4},
  FMX.Platform.Logger.Android.Fix in '..\..\FMXFixes\FMX.Platform.Logger.Android.Fix.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
