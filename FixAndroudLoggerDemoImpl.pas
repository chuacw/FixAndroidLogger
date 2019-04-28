unit FixAndroudLoggerDemoImpl;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TfrmLogDemo = class(TForm)
    edLog: TEdit;
    btnSendToLog: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    btnChangeTag: TButton;
    edTagName: TEdit;
    procedure btnSendToLogClick(Sender: TObject);
    procedure btnChangeTagClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogDemo: TfrmLogDemo;

implementation
uses
  FMX.Platform, FMX.Platform.Logger.Android.Fix;

{$R *.fmx}

procedure TfrmLogDemo.btnChangeTagClick(Sender: TObject);
var
  LChangeTagService: IFMXChangeTag;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXChangeTag,
    LChangeTagService) then
    begin
      LChangeTagService.Tag := edTagName.Text;
    end;
end;

procedure TfrmLogDemo.btnSendToLogClick(Sender: TObject);
var
  LLogService: IFMXLoggingService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService,
    LLogService) then
    begin
      LLogService.Log(edLog.Text, []);
    end;
end;

end.
