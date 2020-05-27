unit FMX.Platform.Logger.Android.Fix;

interface
uses
{$IF DEFINED(ANDROID)}
  Androidapi.Log,
{$ENDIF}
  FMX.Platform;

type
  /// <summary>Provides the ability to change the default tag used when logging.</summary>
  IFMXChangeTag = interface
    ['{2D2FE594-3F82-4A6D-8C51-60918C76C1B8}']
    procedure ChangeTag(const ANewTag: string);
    function GetTag: string;
    property Tag: string read GetTag write ChangeTag;
  end;

  /// <summary>Provides the ability to log messages with specific tags</summary>
  IFMXTagPriority = interface
    ['{6CC65368-A359-4DE4-B987-5D433D093110}']

    /// <summary>Log a debug message.</summary>
    procedure d(const Msg: string); overload;
    /// <summary>Log a debug message with a tag.</summary>
    procedure d(const Tag, Msg: string); overload;

    /// <summary>Log an error message.</summary>
    procedure e(const Msg: string); overload;
    /// <summary>Log an error message with a tag.</summary>
    procedure e(const Tag, Msg: string); overload;

    /// <summary>Log an info message.</summary>
    procedure i(const Msg: string); overload;
    /// <summary>Log an info message with a tag.</summary>
    procedure i(const Tag, Msg: string); overload;

    /// <summary>Log a verbose message.</summary>
    procedure v(const Msg: string); overload;
    /// <summary>Log a verbose message with a tag.</summary>
    procedure v(const Tag, Msg: string); overload;
  end;

{$IF DEFINED(ANDROID)}
type

  TFixedAndroidLoggerService = class(TInterfacedObject, IFMXLoggingService,
    IFMXChangeTag, IFMXTagPriority)
  protected
    FLogger: IFMXLoggingService;
    FTag: string;
    procedure Clear;
  public
    procedure ChangeTag(const ANewTag: string);
    function GetTag: string;
    constructor Create(const ATag: string='DELPHIFMX');
    destructor Destroy; override;
    procedure Log(const AFormat: string; const AParams: array of const);

    procedure LogPriority(APriority: android_LogPriority; const ATag, AMsg: string);

    // IFMXTagPriority
    procedure d(const Msg: string); overload;
    procedure d(const Tag, Msg: string); overload; virtual;
    procedure e(const Msg: string); overload;
    procedure e(const Tag, Msg: string); overload; virtual;
    procedure i(const Msg: string); overload;
    procedure i(const Tag, Msg: string); overload; virtual;
    procedure v(const Msg: string); overload;
    procedure v(const Tag, Msg: string); overload; virtual;

    property Tag: string read GetTag write ChangeTag;
  end;

  Log = class abstract
  strict private
    class var FLogger: IInterface;
    class var FLogPriority: IFMXTagPriority;
    class function GetLogger: IInterface; static;
    class function GetLogPriority: IFMXTagPriority; static;
  protected
    /// <summary>Referece to the logger service.</summary>
    class property Logger: IInterface read GetLogger;
    class property LogPriority: IFMXTagPriority read GetLogPriority;
  public
    /// <summary>Log a simple debug message.</summary>
    class procedure d(const Msg: string); overload;
    /// <summary>Log a debug message with a tag.</summary>
    class procedure d(const Tag, Msg: string); overload;

    /// <summary>Log a simple error message.</summary>
    class procedure e(const Msg: string); overload;
    /// <summary>Log an error message with a tag.</summary>
    class procedure e(const Tag, Msg: string); overload;

    /// <summary>Log a simple info message.</summary>
    class procedure i(const Msg: string); overload;
    /// <summary>Log an info message with a tag.</summary>
    class procedure i(const Tag, Msg: string); overload;

    /// <summary>Log a verbose message.</summary>
    class procedure v(const Msg: string); overload;
    /// <summary>Log an verbose message with a tag.</summary>
    class procedure v(const Tag, Msg: string); overload;
  end;

{$ELSE}
type

  Log = class abstract
  strict private
    class var FLogger: IInterface;
    class var FLogPriority: IFMXTagPriority;
    class function GetLogger: IInterface; static;
    class function GetLogPriority: IFMXTagPriority; static;
  protected
    /// <summary>Referece to the logger service.</summary>
    class property Logger: IInterface read GetLogger;
    class property LogPriority: IFMXTagPriority read GetLogPriority;
  public
    /// <summary>Log a simple debug message.</summary>
    class procedure d(const Msg: string); overload; static;
    /// <summary>Log a debug message with a tag.</summary>
    class procedure d(const Tag, Msg: string); overload; static;

    /// <summary>Log a simple error message.</summary>
    class procedure e(const Msg: string); overload; static;
    /// <summary>Log an error message with a tag.</summary>
    class procedure e(const Tag, Msg: string); overload; static;

    /// <summary>Log a simple info message.</summary>
    class procedure i(const Msg: string); overload; static;
    /// <summary>Log an info message with a tag.</summary>
    class procedure i(const Tag, Msg: string); overload; static;

    /// <summary>Log a verbose message.</summary>
    class procedure v(const Msg: string); overload; static;
    /// <summary>Log an verbose message with a tag.</summary>
    class procedure v(const Tag, Msg: string); overload; static;
  end;

  android_LogPriority = (
    ANDROID_LOG_UNKNOWN,
    ANDROID_LOG_DEFAULT,
    ANDROID_LOG_VERBOSE,
    ANDROID_LOG_DEBUG,
    ANDROID_LOG_INFO,
    ANDROID_LOG_WARN,
    ANDROID_LOG_ERROR,
    ANDROID_LOG_FATAL,
    ANDROID_LOG_SILENT
  );

  TFixedAndroidLoggerService = class(TInterfacedObject, IFMXLoggingService,
    IFMXChangeTag, IFMXTagPriority)
  protected
    FLogger: IFMXLoggingService;
    FTag: string;
    procedure Clear;
  public

    class procedure LogPriority(APriority: android_LogPriority; const ATag, AMsg: string); static;

    // IFMXTagPriority
    procedure d(const Msg: string); overload;
    procedure d(const Tag, Msg: string); overload; virtual;
    procedure e(const Msg: string); overload;
    procedure e(const Tag, Msg: string); overload; virtual;
    procedure i(const Msg: string); overload;
    procedure i(const Tag, Msg: string); overload; virtual;
    procedure v(const Msg: string); overload;
    procedure v(const Tag, Msg: string); overload; virtual;

    procedure ChangeTag(const ANewTag: string);
    function GetTag: string;
    constructor Create(const ATag: string='DELPHIFMX');
    destructor Destroy; override;
    procedure Log(const AFormat: string; const AParams: array of const);
    property Tag: string read GetTag write ChangeTag;
  end;

{$ENDIF}

  procedure ChangeTag(const ATag: string);
  function  DefaultLoggerInstalled: Boolean;
  procedure InstalLReplacementLogger(const ATag: string='DELPHIFMX');
  function  ReplacementLoggerInstalled: Boolean;
var
  GReplacementLogger: TFixedAndroidLoggerService;

implementation
{$IF DEFINED(ANDROID)}
uses
  System.SysUtils, Androidapi.Helpers;

const
  AndroidLogLib         = '/usr/lib/liblog.so';

function __android_log_write(Priority: android_LogPriority; const Tag, Text: MarshaledAString): Integer; cdecl;
  external AndroidLogLib name '__android_log_write';

var
  IReplacementLogger: IFMXLoggingService;

//class procedure Log.d(const Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.d(Msg);
//end;
//
//class procedure Log.d(const Tag, Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.d(Tag, Msg);
//end;
//
//class procedure Log.e(const Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.e('', Msg);
//end;
//
//class procedure Log.e(const Tag, Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.e(Tag, Msg);
//end;
//
//class procedure Log.i(const Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.i(Msg);
//end;
//
//class procedure Log.i(const Tag, Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.i(Tag, Msg);
//end;
//
//class procedure Log.v(const Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.v(Msg);
//end;
//
//class procedure Log.v(const Tag, Msg: string);
//begin
//  if LogPriority <> nil then
//    LogPriority.v(Tag, Msg);
//end;

{$ELSE}
uses
  {$IF DEFINED(MSWINDOWS)}
  Winapi.Windows,
  {$ENDIF}
  System.SysUtils;

var
  IReplacementLogger: IFMXLoggingService;
{$ENDIF}

procedure ChangeTag(const ATag: string);
var
  LLogger: IFMXLoggingService;
  LFMXChangeTag: IFMXChangeTag;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService, LLogger) and
    Supports(LLogger, IFMXChangeTag, LFMXChangeTag) then
      LFMXChangeTag.ChangeTag(ATag);
end;

procedure InstallReplacementLogger(const ATag: string='DELPHIFMX');
begin
  if (GReplacementLogger <> nil) and (GReplacementLogger.Tag <> ATag) then
    begin
      if ATag <> '' then
        GReplacementLogger.ChangeTag(ATag);
      Exit;
    end;
  if (GReplacementLogger = nil) then
    GReplacementLogger := TFixedAndroidLoggerService.Create(ATag);
end;

function ReplacementLoggerInstalled: Boolean;
begin
  Result := IReplacementLogger <> nil;
end;

function DefaultLoggerInstalled: Boolean;
var
  LLogger: IInterface;
begin
  Result := False;
  if TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService, LLogger) then
    Result := LLogger <> nil;
end;

class function Log.GetLogger: IInterface;
begin
  if FLogger = nil then
    TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService, FLogger);
  Result := FLogger;
end;

class function Log.GetLogPriority: IFMXTagPriority;
var
  LLogger: IInterface;
begin
  LLogger := Logger;
  if (LLogger <> nil) and (FLogPriority = nil) then
    Supports(LLogger, IFMXTagPriority, FLogPriority);
  Result := FLogPriority;
end;

class procedure Log.d(const Msg: string);
begin
  d('', Msg);
end;

class procedure Log.d(const Tag, Msg: string);
begin
  if LogPriority <> nil then
    LogPriority.d(Tag, Msg);
end;

class procedure Log.e(const Msg: string);
begin
  e('', Msg);
end;

class procedure Log.e(const Tag, Msg: string);
begin
  if LogPriority <> nil then
    LogPriority.e(Tag, Msg);
end;

class procedure Log.i(const Msg: string);
begin
  i('', Msg);
end;

class procedure Log.i(const Tag, Msg: string);
begin
  if LogPriority <> nil then
    LogPriority.i(Tag, Msg);
end;

class procedure Log.v(const Msg: string);
begin
  v('', Msg);
end;

class procedure Log.v(const Tag, Msg: string);
begin
  if LogPriority <> nil then
    LogPriority.v(Tag, Msg);
end;

{ TFixedAndroidLoggerService }
procedure TFixedAndroidLoggerService.ChangeTag(const ANewTag: string);
begin
  FTag := ANewTag;
end;

function TFixedAndroidLoggerService.GetTag: string;
begin
  Result := FTag;
end;

procedure TFixedAndroidLoggerService.Clear;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXChangeTag);
  TPlatformServices.Current.RemovePlatformService(IFMXLoggingService);
  FLogger := nil;
  IReplacementLogger := nil;
end;

constructor TFixedAndroidLoggerService.Create(const ATag: string);
begin
  inherited Create;
  if TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService, FLogger) then
    begin
      TPlatformServices.Current.RemovePlatformService(IFMXLoggingService);
    end;
  FTag := ATag;
  IReplacementLogger := Self;
  TPlatformServices.Current.AddPlatformService(IFMXLoggingService, IReplacementLogger);
  TPlatformServices.Current.AddPlatformService(IFMXChangeTag, IReplacementLogger);
end;

destructor TFixedAndroidLoggerService.Destroy;
begin
  Clear;
  inherited;
end;

{$IF DEFINED(ANDROID)}
procedure TFixedAndroidLoggerService.LogPriority(APriority: android_LogPriority;
  const ATag, AMsg: string);
var
  LTag, LMsg: MarshaledAString;
  M: TMarshaller;
begin
  if ATag <> '' then
    LTag := M.AsUtf8(ATag).ToPointer else
    LTag := M.AsUtf8(FTag).ToPointer;
  LMsg := M.AsUtf8(AMsg).ToPointer;
  __android_log_write(APriority, LTag, LMsg);
end;

procedure TFixedAndroidLoggerService.d(const Msg: string);
begin
  d('', Msg);
end;

procedure TFixedAndroidLoggerService.d(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_DEBUG, Tag, Msg);
end;

procedure TFixedAndroidLoggerService.e(const Msg: string);
begin
  e('', Msg);
end;

procedure TFixedAndroidLoggerService.e(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_ERROR, Tag, Msg);
end;

procedure TFixedAndroidLoggerService.i(const Msg: string);
begin
  i('', Msg);
end;

procedure TFixedAndroidLoggerService.i(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_INFO, Tag, Msg);
end;

procedure TFixedAndroidLoggerService.v(const Msg: string);
begin
  v('', Msg);
end;

procedure TFixedAndroidLoggerService.v(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_VERBOSE, Tag, Msg);
end;
{$ELSE}
class procedure TFixedAndroidLoggerService.LogPriority(APriority: android_LogPriority;
  const ATag, AMsg: string);
{$IF DEFINED(MSWINDOWS)}
var
  LMsg: PChar;
{$ENDIF}
begin
  {$IF DEFINED(MSWINDOWS)}
    LMsg := PChar(Format('Tag: %s Msg: %s', [ATag, AMsg]));
    OutputDebugString(LMsg);
  {$ENDIF}
  // do nothing on other systems
end;

procedure TFixedAndroidLoggerService.d(const Msg: string);
begin
  d('', Msg);
end;

procedure TFixedAndroidLoggerService.d(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_DEBUG, Tag, Msg);
end;

procedure TFixedAndroidLoggerService.e(const Msg: string);
begin
  e('', Msg);
end;

procedure TFixedAndroidLoggerService.e(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_ERROR, Tag, Msg);
end;

procedure TFixedAndroidLoggerService.i(const Msg: string);
begin
  i('', Msg);
end;

procedure TFixedAndroidLoggerService.i(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_INFO, Tag, Msg);
end;

procedure TFixedAndroidLoggerService.v(const Msg: string);
begin
  v('', Msg);
end;

procedure TFixedAndroidLoggerService.v(const Tag, Msg: string);
begin
  LogPriority(android_LogPriority.ANDROID_LOG_VERBOSE, Tag, Msg);
end;
{$ENDIF}

procedure TFixedAndroidLoggerService.Log(const AFormat: string;
  const AParams: array of const);
{$IF DEFINED(ANDROID)}
var
  Msg: string;
  M: TMarshaller;
  LTag, LMsg: MarshaledAString;
{$ENDIF}
begin
{$IF DEFINED(ANDROID)}
  if Length(AParams) = 0 then
    Msg := AFormat
  else
    Msg := Format(AFormat, AParams);

  LTag := M.AsUtf8(FTag).ToPointer;
  LMsg := M.AsUtf8(Msg).ToPointer;
  __android_log_write(android_LogPriority.ANDROID_LOG_INFO, LTag, LMsg);
{$ELSE}
  if Assigned(FLogger) then
    begin
      FLogger.Log(AFormat, AParams);
    end;
{$ENDIF}
end;

initialization
  InstallReplacementLogger;
finalization
  if GReplacementLogger <> nil then
    begin
      GReplacementLogger.Clear;
      GReplacementLogger.DisposeOf;
    end;
end.
