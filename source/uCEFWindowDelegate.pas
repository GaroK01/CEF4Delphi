// ************************************************************************
// ***************************** CEF4Delphi *******************************
// ************************************************************************
//
// CEF4Delphi is based on DCEF3 which uses CEF to embed a chromium-based
// browser in Delphi applications.
//
// The original license of DCEF3 still applies to CEF4Delphi.
//
// For more information about CEF4Delphi visit :
//         https://www.briskbard.com/index.php?lang=en&pageid=cef
//
//        Copyright � 2023 Salvador Diaz Fau. All rights reserved.
//
// ************************************************************************
// ************ vvvv Original license and comments below vvvv *************
// ************************************************************************
(*
 *                       Delphi Chromium Embedded 3
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 * Web site   : http://www.progdigy.com
 * Repository : http://code.google.com/p/delphichromiumembedded/
 * Group      : http://groups.google.com/group/delphichromiumembedded
 *
 * Embarcadero Technologies, Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 *)

unit uCEFWindowDelegate;

{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
{$ENDIF}

{$I cef.inc}

{$IFNDEF TARGET_64BITS}{$ALIGN ON}{$ENDIF}
{$MINENUMSIZE 4}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, System.SysUtils,
  {$ELSE}
  Classes, SysUtils,
  {$ENDIF}
  uCEFBaseRefCounted, uCEFInterfaces, uCEFTypes, uCEFPanelDelegate;

type
  TCefWindowDelegateRef = class(TCefPanelDelegateRef, ICefWindowDelegate)
    protected
      procedure OnWindowCreated(const window_: ICefWindow);
      procedure OnWindowClosing(const window_: ICefWindow);
      procedure OnWindowDestroyed(const window_: ICefWindow);
      procedure OnWindowActivationChanged(const window_: ICefWindow; active: boolean);
      procedure OnWindowBoundsChanged(const window_: ICefWindow; const new_bounds: TCefRect);
      procedure OnGetParentWindow(const window_: ICefWindow; var is_menu, can_activate_menu: boolean; var aResult : ICefWindow);
      procedure OnGetInitialBounds(const window_: ICefWindow; var aResult : TCefRect);
      procedure OnGetInitialShowState(const window_: ICefWindow; var aResult : TCefShowState);
      procedure OnIsFrameless(const window_: ICefWindow; var aResult : boolean);
      procedure OnWithStandardWindowButtons(const window_: ICefWindow; var aResult : boolean);
      procedure OnGetTitlebarHeight(const window_: ICefWindow; var titlebar_height: Single; var aResult : boolean);
      procedure OnCanResize(const window_: ICefWindow; var aResult : boolean);
      procedure OnCanMaximize(const window_: ICefWindow; var aResult : boolean);
      procedure OnCanMinimize(const window_: ICefWindow; var aResult : boolean);
      procedure OnCanClose(const window_: ICefWindow; var aResult : boolean);
      procedure OnAccelerator(const window_: ICefWindow; command_id: Integer; var aResult : boolean);
      procedure OnKeyEvent(const window_: ICefWindow; const event: TCefKeyEvent; var aResult : boolean);

    public
      class function UnWrap(data: Pointer): ICefWindowDelegate;
  end;

  TCefWindowDelegateOwn = class(TCefPanelDelegateOwn, ICefWindowDelegate)
    protected
      procedure OnWindowCreated(const window_: ICefWindow); virtual;
      procedure OnWindowClosing(const window_: ICefWindow); virtual;
      procedure OnWindowDestroyed(const window_: ICefWindow); virtual;
      procedure OnWindowActivationChanged(const window_: ICefWindow; active: boolean); virtual;
      procedure OnWindowBoundsChanged(const window_: ICefWindow; const new_bounds: TCefRect); virtual;
      procedure OnGetParentWindow(const window_: ICefWindow; var is_menu, can_activate_menu: boolean; var aResult : ICefWindow); virtual;
      procedure OnGetInitialBounds(const window_: ICefWindow; var aResult : TCefRect); virtual;
      procedure OnGetInitialShowState(const window_: ICefWindow; var aResult : TCefShowState); virtual;
      procedure OnIsFrameless(const window_: ICefWindow; var aResult : boolean); virtual;
      procedure OnWithStandardWindowButtons(const window_: ICefWindow; var aResult : boolean); virtual;
      procedure OnGetTitlebarHeight(const window_: ICefWindow; var titlebar_height: Single; var aResult : boolean); virtual;
      procedure OnCanResize(const window_: ICefWindow; var aResult : boolean); virtual;
      procedure OnCanMaximize(const window_: ICefWindow; var aResult : boolean); virtual;
      procedure OnCanMinimize(const window_: ICefWindow; var aResult : boolean); virtual;
      procedure OnCanClose(const window_: ICefWindow; var aResult : boolean); virtual;
      procedure OnAccelerator(const window_: ICefWindow; command_id: Integer; var aResult : boolean); virtual;
      procedure OnKeyEvent(const window_: ICefWindow; const event: TCefKeyEvent; var aResult : boolean); virtual;

      procedure InitializeCEFMethods; override;

    public
      constructor Create; override;
  end;

  TCustomWindowDelegate = class(TCefWindowDelegateOwn)
    protected
      FEvents : Pointer;

      // ICefViewDelegate
      procedure OnGetPreferredSize(const view: ICefView; var aResult : TCefSize); override;
      procedure OnGetMinimumSize(const view: ICefView; var aResult : TCefSize); override;
      procedure OnGetMaximumSize(const view: ICefView; var aResult : TCefSize); override;
      procedure OnGetHeightForWidth(const view: ICefView; width: Integer; var aResult: Integer); override;
      procedure OnParentViewChanged(const view: ICefView; added: boolean; const parent: ICefView); override;
      procedure OnChildViewChanged(const view: ICefView; added: boolean; const child: ICefView); override;
      procedure OnWindowChanged(const view: ICefView; added: boolean); override;
      procedure OnLayoutChanged(const view: ICefView; new_bounds: TCefRect); override;
      procedure OnFocus(const view: ICefView); override;
      procedure OnBlur(const view: ICefView); override;

      // ICefWindowDelegate
      procedure OnWindowCreated(const window_: ICefWindow); override;
      procedure OnWindowClosing(const window_: ICefWindow); override;
      procedure OnWindowDestroyed(const window_: ICefWindow); override;
      procedure OnWindowActivationChanged(const window_: ICefWindow; active: boolean); override;
      procedure OnWindowBoundsChanged(const window_: ICefWindow; const new_bounds: TCefRect); override;
      procedure OnGetParentWindow(const window_: ICefWindow; var is_menu, can_activate_menu: boolean; var aResult : ICefWindow); override;
      procedure OnGetInitialBounds(const window_: ICefWindow; var aResult : TCefRect); override;
      procedure OnGetInitialShowState(const window_: ICefWindow; var aResult : TCefShowState); override;
      procedure OnIsFrameless(const window_: ICefWindow; var aResult : boolean); override;
      procedure OnWithStandardWindowButtons(const window_: ICefWindow; var aResult : boolean); override;
      procedure OnGetTitlebarHeight(const window_: ICefWindow; var titlebar_height: Single; var aResult : boolean); override;
      procedure OnCanResize(const window_: ICefWindow; var aResult : boolean); override;
      procedure OnCanMaximize(const window_: ICefWindow; var aResult : boolean); override;
      procedure OnCanMinimize(const window_: ICefWindow; var aResult : boolean); override;
      procedure OnCanClose(const window_: ICefWindow; var aResult : boolean); override;
      procedure OnAccelerator(const window_: ICefWindow; command_id: Integer; var aResult : boolean); override;
      procedure OnKeyEvent(const window_: ICefWindow; const event: TCefKeyEvent; var aResult : boolean); override;

    public
      constructor Create(const events: ICefWindowDelegateEvents); reintroduce;
  end;

implementation

uses
  uCEFLibFunctions, uCEFMiscFunctions, uCEFWindow, uCEFConstants;


// **************************************************************
// ******************* TCefWindowDelegateRef ********************
// **************************************************************

procedure TCefWindowDelegateRef.OnWindowCreated(const window_: ICefWindow);
begin
  PCefWindowDelegate(FData)^.on_window_created(PCefWindowDelegate(FData), CefGetData(window_));
end;

procedure TCefWindowDelegateRef.OnWindowClosing(const window_: ICefWindow);
begin
  PCefWindowDelegate(FData)^.on_window_closing(PCefWindowDelegate(FData), CefGetData(window_));
end;

procedure TCefWindowDelegateRef.OnWindowDestroyed(const window_: ICefWindow);
begin
  PCefWindowDelegate(FData)^.on_window_destroyed(PCefWindowDelegate(FData), CefGetData(window_));
end;

procedure TCefWindowDelegateRef.OnWindowActivationChanged(const window_: ICefWindow; active: boolean);
begin
  PCefWindowDelegate(FData)^.on_window_activation_changed(PCefWindowDelegate(FData), CefGetData(window_), ord(active));
end;

procedure TCefWindowDelegateRef.OnWindowBoundsChanged(const window_: ICefWindow; const new_bounds: TCefRect);
begin
  PCefWindowDelegate(FData)^.on_window_bounds_changed(PCefWindowDelegate(FData), CefGetData(window_), @new_bounds);
end;

procedure TCefWindowDelegateRef.OnGetParentWindow(const window_            : ICefWindow;
                                                  var   is_menu           : boolean;
                                                  var   can_activate_menu : boolean;
                                                  var   aResult           : ICefWindow);
var
  TempIsMenu, TempCanActivateMenu : integer;
begin
  TempIsMenu          := ord(is_menu);
  TempCanActivateMenu := ord(can_activate_menu);
  aResult             := TCefWindowRef.UnWrap(PCefWindowDelegate(FData)^.get_parent_window(PCefWindowDelegate(FData),
                                                                                           CefGetData(window_),
                                                                                           @TempIsMenu,
                                                                                           @TempCanActivateMenu));
  is_menu           := TempIsMenu <> 0;
  can_activate_menu := TempCanActivateMenu <> 0;
end;

procedure TCefWindowDelegateRef.OnGetInitialBounds(const window_: ICefWindow; var aResult : TCefRect);
begin
  aResult := PCefWindowDelegate(FData)^.get_initial_bounds(PCefWindowDelegate(FData), CefGetData(window_));
end;

procedure TCefWindowDelegateRef.OnGetInitialShowState(const window_: ICefWindow; var aResult : TCefShowState);
begin
  aResult := PCefWindowDelegate(FData)^.get_initial_show_state(PCefWindowDelegate(FData), CefGetData(window_));
end;

procedure TCefWindowDelegateRef.OnIsFrameless(const window_: ICefWindow; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.is_frameless(PCefWindowDelegate(FData), CefGetData(window_)) <> 0);
end;

procedure TCefWindowDelegateRef.OnWithStandardWindowButtons(const window_: ICefWindow; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.with_standard_window_buttons(PCefWindowDelegate(FData), CefGetData(window_)) <> 0);
end;

procedure TCefWindowDelegateRef.OnGetTitlebarHeight(const window_: ICefWindow; var titlebar_height: Single; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.get_titlebar_height(PCefWindowDelegate(FData), CefGetData(window_), @titlebar_height) <> 0);
end;

procedure TCefWindowDelegateRef.OnCanResize(const window_: ICefWindow; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.can_resize(PCefWindowDelegate(FData), CefGetData(window_)) <> 0);
end;

procedure TCefWindowDelegateRef.OnCanMaximize(const window_: ICefWindow; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.can_maximize(PCefWindowDelegate(FData), CefGetData(window_)) <> 0);
end;

procedure TCefWindowDelegateRef.OnCanMinimize(const window_: ICefWindow; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.can_minimize(PCefWindowDelegate(FData), CefGetData(window_)) <> 0);
end;

procedure TCefWindowDelegateRef.OnCanClose(const window_: ICefWindow; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.can_close(PCefWindowDelegate(FData), CefGetData(window_)) <> 0);
end;

procedure TCefWindowDelegateRef.OnAccelerator(const window_: ICefWindow; command_id: Integer; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.on_accelerator(PCefWindowDelegate(FData), CefGetData(window_), command_id) <> 0);
end;

procedure TCefWindowDelegateRef.OnKeyEvent(const window_: ICefWindow; const event: TCefKeyEvent; var aResult : boolean);
begin
  aResult := (PCefWindowDelegate(FData)^.on_key_event(PCefWindowDelegate(FData), CefGetData(window_), @event) <> 0);
end;

class function TCefWindowDelegateRef.UnWrap(data: Pointer): ICefWindowDelegate;
begin
  if (data <> nil) then
    Result := Create(data) as ICefWindowDelegate
   else
    Result := nil;
end;


// **************************************************************
// ******************* TCefWindowDelegateOwn ********************
// **************************************************************

procedure cef_window_delegate_on_window_created(self: PCefWindowDelegate; window_: PCefWindow); stdcall;
var
  TempObject : TObject;
begin
  TempObject := CefGetObject(self);

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnWindowCreated(TCefWindowRef.UnWrap(window_));
end;

procedure cef_window_delegate_on_window_destroyed(self: PCefWindowDelegate; window_: PCefWindow); stdcall;
var
  TempObject : TObject;
begin
  TempObject := CefGetObject(self);

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnWindowDestroyed(TCefWindowRef.UnWrap(window_));
end;

procedure cef_window_delegate_on_window_activation_changed(self: PCefWindowDelegate; window_: PCefWindow; active: integer); stdcall;
var
  TempObject : TObject;
begin
  TempObject := CefGetObject(self);

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnWindowActivationChanged(TCefWindowRef.UnWrap(window_),
                                                                active <> 0);
end;

function cef_window_delegate_get_parent_window(self              : PCefWindowDelegate;
                                               window_            : PCefWindow;
                                               is_menu           : PInteger;
                                               can_activate_menu : PInteger): PCefWindow; stdcall;
var
  TempObject : TObject;
  TempWindow : ICefWindow;
  TempIsMenu, TempCanActivateMenu : boolean;
begin
  TempObject := CefGetObject(self);
  TempWindow := nil;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) and (is_menu <> nil) and (can_activate_menu <> nil) then
    begin
      TempIsMenu          := (is_menu^           <> 0);
      TempCanActivateMenu := (can_activate_menu^ <> 0);

      TCefWindowDelegateOwn(TempObject).OnGetParentWindow(TCefWindowRef.UnWrap(window_),
                                                          TempIsMenu,
                                                          TempCanActivateMenu,
                                                          TempWindow);
      is_menu^           := ord(TempIsMenu);
      can_activate_menu^ := ord(TempCanActivateMenu);
    end;

  Result := CefGetData(TempWindow);
end;

function cef_window_delegate_get_initial_bounds(self: PCefWindowDelegate; window_: PCefWindow): TCefRect; stdcall;
var
  TempObject : TObject;
  TempRect   : TCefRect;
begin
  TempObject      := CefGetObject(self);
  TempRect.x      := 0;
  TempRect.y      := 0;
  TempRect.width  := 0;
  TempRect.height := 0;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnGetInitialBounds(TCefWindowRef.UnWrap(window_),
                                                         TempRect);

  Result.x      := TempRect.x;
  Result.y      := TempRect.y;
  Result.width  := TempRect.width;
  Result.height := TempRect.height;
end;

function cef_window_delegate_get_initial_show_state(self: PCefWindowDelegate; window_: PCefWindow): TCefShowState; stdcall;
var
  TempObject : TObject;
begin
  TempObject := CefGetObject(self);
  Result     := CEF_SHOW_STATE_NORMAL;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnGetInitialShowState(TCefWindowRef.UnWrap(window_),
                                                            Result);
end;

function cef_window_delegate_is_frameless(self: PCefWindowDelegate; window_: PCefWindow): Integer; stdcall;
var
  TempObject      : TObject;
  TempIsFrameless : boolean;
begin
  TempObject      := CefGetObject(self);
  TempIsFrameless := False;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnIsFrameless(TCefWindowRef.UnWrap(window_), TempIsFrameless);

  Result := ord(TempIsFrameless);
end;

function cef_window_delegate_can_resize(self: PCefWindowDelegate; window_: PCefWindow): Integer; stdcall;
var
  TempObject    : TObject;
  TempCanResize : boolean;
begin
  TempObject    := CefGetObject(self);
  TempCanResize := True;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnCanResize(TCefWindowRef.UnWrap(window_), TempCanResize);

  Result := ord(TempCanResize);
end;

function cef_window_delegate_can_maximize(self: PCefWindowDelegate; window_: PCefWindow): Integer; stdcall;
var
  TempObject      : TObject;
  TempCanMaximize : boolean;
begin
  TempObject      := CefGetObject(self);
  TempCanMaximize := True;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnCanMaximize(TCefWindowRef.UnWrap(window_), TempCanMaximize);

  Result := ord(TempCanMaximize);
end;

function cef_window_delegate_can_minimize(self: PCefWindowDelegate; window_: PCefWindow): Integer; stdcall;
var
  TempObject      : TObject;
  TempCanMinimize : boolean;
begin
  TempObject      := CefGetObject(self);
  TempCanMinimize := True;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnCanMinimize(TCefWindowRef.UnWrap(window_), TempCanMinimize);

  Result := ord(TempCanMinimize);
end;

function cef_window_delegate_can_close(self: PCefWindowDelegate; window_: PCefWindow): Integer; stdcall;
var
  TempObject   : TObject;
  TempCanClose : boolean;
begin
  TempObject   := CefGetObject(self);
  TempCanClose := True;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnCanClose(TCefWindowRef.UnWrap(window_), TempCanClose);

  Result := ord(TempCanClose);
end;

function cef_window_delegate_on_accelerator(self       : PCefWindowDelegate;
                                            window_     : PCefWindow;
                                            command_id : Integer): Integer; stdcall;
var
  TempObject : TObject;
  TempResult : boolean;
begin
  TempObject := CefGetObject(self);
  TempResult := False;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnAccelerator(TCefWindowRef.UnWrap(window_), command_id, TempResult);

  Result := ord(TempResult);
end;

function cef_window_delegate_on_key_event(      self   : PCefWindowDelegate;
                                                window_ : PCefWindow;
                                          const event  : PCefKeyEvent): Integer; stdcall;
var
  TempObject : TObject;
  TempResult : boolean;
begin
  TempObject := CefGetObject(self);
  TempResult := False;

  if (TempObject <> nil) and (TempObject is TCefWindowDelegateOwn) then
    TCefWindowDelegateOwn(TempObject).OnKeyEvent(TCefWindowRef.UnWrap(window_), event^, TempResult);

  Result := ord(TempResult);
end;

constructor TCefWindowDelegateOwn.Create;
begin
  inherited CreateData(SizeOf(TCefWindowDelegate));

  InitializeCEFMethods;
end;

procedure TCefWindowDelegateOwn.InitializeCEFMethods;
begin
  inherited InitializeCEFMethods;

  with PCefWindowDelegate(FData)^ do
    begin
      on_window_created                := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_on_window_created;
      on_window_destroyed              := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_on_window_destroyed;
      on_window_activation_changed     := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_on_window_activation_changed;
      get_parent_window                := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_get_parent_window;
      get_initial_bounds               := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_get_initial_bounds;
      get_initial_show_state           := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_get_initial_show_state;
      is_frameless                     := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_is_frameless;
      can_resize                       := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_can_resize;
      can_maximize                     := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_can_maximize;
      can_minimize                     := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_can_minimize;
      can_close                        := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_can_close;
      on_accelerator                   := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_on_accelerator;
      on_key_event                     := {$IFDEF FPC}@{$ENDIF}cef_window_delegate_on_key_event;
    end;
end;

procedure TCefWindowDelegateOwn.OnWindowCreated(const window_: ICefWindow);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnWindowClosing(const window_: ICefWindow);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnWindowDestroyed(const window_: ICefWindow);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnWindowActivationChanged(const window_: ICefWindow; active: boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnWindowBoundsChanged(const window_: ICefWindow; const new_bounds: TCefRect);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnGetParentWindow(const window_: ICefWindow; var is_menu, can_activate_menu: boolean; var aResult : ICefWindow);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnGetInitialBounds(const window_: ICefWindow; var aResult : TCefRect);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnGetInitialShowState(const window_: ICefWindow; var aResult : TCefShowState);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnIsFrameless(const window_: ICefWindow; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnWithStandardWindowButtons(const window_: ICefWindow; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnGetTitlebarHeight(const window_: ICefWindow; var titlebar_height: Single; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnCanResize(const window_: ICefWindow; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnCanMaximize(const window_: ICefWindow; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnCanMinimize(const window_: ICefWindow; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnCanClose(const window_: ICefWindow; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnAccelerator(const window_: ICefWindow; command_id: Integer; var aResult : boolean);
begin
  //
end;

procedure TCefWindowDelegateOwn.OnKeyEvent(const window_: ICefWindow; const event: TCefKeyEvent; var aResult : boolean);
begin
  //
end;


// **************************************************************
// ******************* TCustomWindowDelegate ********************
// **************************************************************

constructor TCustomWindowDelegate.Create(const events: ICefWindowDelegateEvents);
begin
  inherited Create;

  FEvents := Pointer(events);
end;

procedure TCustomWindowDelegate.OnGetPreferredSize(const view: ICefView; var aResult : TCefSize);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetPreferredSize(view, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetPreferredSize', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnGetMinimumSize(const view: ICefView; var aResult : TCefSize);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetMinimumSize(view, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetMinimumSize', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnGetMaximumSize(const view: ICefView; var aResult : TCefSize);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetMaximumSize(view, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetMaximumSize', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnGetHeightForWidth(const view: ICefView; width: Integer; var aResult: Integer);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetHeightForWidth(view, width, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetHeightForWidth', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnParentViewChanged(const view: ICefView; added: boolean; const parent: ICefView);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnParentViewChanged(view, added, parent);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnParentViewChanged', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnChildViewChanged(const view: ICefView; added: boolean; const child: ICefView);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnChildViewChanged(view, added, child);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnChildViewChanged', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnWindowChanged(const view: ICefView; added: boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnWindowChanged(view, added);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnWindowChanged', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnLayoutChanged(const view: ICefView; new_bounds: TCefRect);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnLayoutChanged(view, new_bounds);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnLayoutChanged', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnFocus(const view: ICefView);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnFocus(view);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnFocus', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnBlur(const view: ICefView);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnBlur(view);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnBlur', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnWindowCreated(const window_: ICefWindow);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnWindowCreated(window_);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnWindowCreated', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnWindowClosing(const window_: ICefWindow);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnWindowClosing(window_);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnWindowClosing', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnWindowDestroyed(const window_: ICefWindow);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnWindowDestroyed(window_);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnWindowDestroyed', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnWindowActivationChanged(const window_: ICefWindow; active: boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnWindowActivationChanged(window_, active);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnWindowActivationChanged', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnWindowBoundsChanged(const window_: ICefWindow; const new_bounds: TCefRect);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnWindowBoundsChanged(window_, new_bounds);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnWindowBoundsChanged', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnGetParentWindow(const window_: ICefWindow; var is_menu, can_activate_menu: boolean; var aResult : ICefWindow);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetParentWindow(window_, is_menu, can_activate_menu, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetParentWindow', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnGetInitialBounds(const window_: ICefWindow; var aResult : TCefRect);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetInitialBounds(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetInitialBounds', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnGetInitialShowState(const window_: ICefWindow; var aResult : TCefShowState);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetInitialShowState(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetInitialShowState', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnIsFrameless(const window_: ICefWindow; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnIsFrameless(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnIsFrameless', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnWithStandardWindowButtons(const window_: ICefWindow; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnWithStandardWindowButtons(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnWithStandardWindowButtons', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnGetTitlebarHeight(const window_: ICefWindow; var titlebar_height: Single; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnGetTitlebarHeight(window_, titlebar_height, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnGetTitlebarHeight', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnCanResize(const window_: ICefWindow; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnCanResize(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnCanResize', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnCanMaximize(const window_: ICefWindow; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnCanMaximize(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnCanMaximize', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnCanMinimize(const window_: ICefWindow; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnCanMinimize(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnCanMinimize', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnCanClose(const window_: ICefWindow; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnCanClose(window_, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnCanClose', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnAccelerator(const window_: ICefWindow; command_id: Integer; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnAccelerator(window_, command_id, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnAccelerator', e) then raise;
  end;
end;

procedure TCustomWindowDelegate.OnKeyEvent(const window_: ICefWindow; const event: TCefKeyEvent; var aResult : boolean);
begin
  try
    if (FEvents <> nil) then
      ICefWindowDelegateEvents(FEvents).doOnKeyEvent(window_, event, aResult);
  except
    on e : exception do
      if CustomExceptionHandler('TCustomWindowDelegate.OnKeyEvent', e) then raise;
  end;
end;


end.

