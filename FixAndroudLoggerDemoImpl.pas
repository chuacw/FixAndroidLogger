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
    Panel3: TPanel;
    edPriorityTag: TEdit;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    btnSendToPriorityLog: TButton;
    rbDebug: TRadioButton;
    rbError: TRadioButton;
    rbVerbose: TRadioButton;
    rbInfo: TRadioButton;
    procedure btnSendToLogClick(Sender: TObject);
    procedure btnChangeTagClick(Sender: TObject);
    procedure btnSendToPriorityLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure Log(const AMsg: string);
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

procedure TfrmLogDemo.btnSendToPriorityLogClick(Sender: TObject);
var
  LLogService: IFMXLoggingService;
  LLogPriority: IFMXTagPriority;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService,
    LLogService) then
    begin
      LLogPriority := LLogService as IFMXTagPriority;

// use the default tags established

      if rbDebug.IsChecked then
        LLogPriority.d(edPriorityTag.Text) else
      if rbError.IsChecked then
        LLogPriority.e(edPriorityTag.Text) else
      if rbInfo.IsChecked then
        LLogPriority.i(edPriorityTag.Text) else
      if rbVerbose.IsChecked then
        LLogPriority.v(edPriorityTag.Text);
    end;
end;

procedure TfrmLogDemo.FormCreate(Sender: TObject);
begin
  Log('Application started.');
end;

procedure TfrmLogDemo.FormDestroy(Sender: TObject);
begin
  Log('Shutting down application.');
end;

procedure TfrmLogDemo.Log(const AMsg: string);
var
  LLogService: IFMXLoggingService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService,
    LLogService) then
    begin
      LLogService.Log(AMsg, []);
    end;
end;

end.
