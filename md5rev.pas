unit md5rev;

interface

  {$B-}
  {$I version.inc}

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ComCtrls, Dialogs, Buttons, ExtCtrls, Menus,
  ShellApi, Clipbrd, IniFiles, md5_unit, XPMan;

type
  int = {$IFDEF D3_less} integer {$ELSE} int64 {$ENDIF};
  MByte = 0..256;
  TDicoExtent = record
    MainLetter : char;
    SubLetters : string[17];
  end;

  TForm1 = class(TForm)
    StatusBarr1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label6: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Edit4: TEdit;
    Edit5: TEdit;
    UDmin: TUpDown;
    Edit6: TEdit;
    UDmax: TUpDown;
    Edit7: TEdit;
    ListBox2: TListBox;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox2: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button2: TButton;
    TabSheet2: TTabSheet;
    popBlog: TPopupMenu;
    Savelog1: TMenuItem;
    Clear1: TMenuItem;
    SavDlg: TSaveDialog;
    OpnDlg: TOpenDialog;
    MainMenu1: TMainMenu;
    mnFile: TMenuItem;
    mnNew: TMenuItem;
    mnTranslate: TMenuItem;
    mnSavLog: TMenuItem;
    N1: TMenuItem;
    iniSavBF: TMenuItem;
    mnReloadBF: TMenuItem;
    mnDelete: TMenuItem;
    N2: TMenuItem;
    mnSpeedTest: TMenuItem;
    mnExit: TMenuItem;
    Priority1: TMenuItem;
    mnPrioLowest: TMenuItem;
    mnPrioNormal: TMenuItem;
    mnPrioHighest: TMenuItem;
    mnPrioTC: TMenuItem;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    Label16: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edIP_01: TEdit;
    edIP_02: TEdit;
    butIP: TBitBtn;
    Edit10: TEdit;
    Edit11: TEdit;
    Label17: TLabel;
    Label19: TLabel;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Edit12: TEdit;
    Edit13: TEdit;
    Button3: TButton;
    Label23: TLabel;
    CheckBox1: TCheckBox;
    Button4: TButton;
    Button5: TButton;
    BitBtn2: TBitBtn;
    Button1: TButton;
    procedure butIPClick(Sender: TObject);
    procedure StatusBarr1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Savelog1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure UDminClick(Sender: TObject; Button: TUDBtnType);
    procedure UDmaxClick(Sender: TObject; Button: TUDBtnType);
    procedure LStrRslClick(Sender: TObject);
    procedure mnTranslateClick(Sender: TObject);
    procedure mnPrioLowestClick(Sender: TObject);
    procedure mnNewClick(Sender: TObject);
    procedure mnFileClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure mnSpeedTestClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure iniSavBFClick(Sender: TObject);
    procedure mnReloadBFClick(Sender: TObject);
    procedure mnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure WarnException(Sender:TObject; E:Exception);
  end;

  function MsgDlg(const Msg:string; AType:TMsgDlgType; AButtons:TMsgDlgButtons; HelpCtx:Longint):word;

const SBDefMsg                         = ' An MD5 implementation';
      exeFrmTitle                      = 'MD5 Recovery Tool';
      BackGroundFile                   = 'bg.bmp';
      MD5Limit                         = 3.4E38; //= 2^128
      MD5AverageSpeed                  = 521000; //average speed
      mbYesNo                          = [mbYes,mbNo];

      Flt_Num                          = '0123456789';
      Flt_Min_abc                      = 'abcdefghijklmnopqrstuvwxyz';
      Flt_Maj_abc                      = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      Flt_abc                          = Flt_Min_abc+Flt_Maj_abc;
      Flt_Min_Stress                   = 'àáâãäåæßçèéêëìíîïñòóôõöøœð¤ùúûüÿý';
      Flt_Maj_Stress                   = 'ÀÁÂÃÄÅÆßÇÐÈÉÊË1ÌÍÎÏ£Ñ0ÒÓÔÕÖØ$ÙÚÛÜŸÝ¥';
      Flt_Stress                       = Flt_Min_Stress+Flt_Maj_Stress;     //àáâãäåæÀÁÂÃÄÅÆßçÇÐèéêëÈÉÊËìíîïÌÍÎÏñÑòóôõöÒÓÔÕÖøØœðùúûüÙÚÛÜÿýŸÝ
      Flt_Hexa                         = Flt_Num+'abcdefABCDEF';
      Flt_SerialKey                    = Flt_Num+'ABCDEF- ';

      INI_Section                      = 'MD5';
      INI_FileName                     = 'md5bf.cov';
      ACT_BASE                         = $0; //determines the last action
      ACT_Null                         = ACT_BASE;
      ACT_IP                           = ACT_BASE+1;
      ACT_Dico                         = ACT_BASE+2;
      ACT_BruteForce                   = ACT_BASE+3;

      NWExtension                      = 11;
      DicoWords                        : array[0..NWExtension] of TDicoExtent
                       = ( (MainLetter: 'a'; SubLetters: 'AàáâãäåæÀÁÂÃÄÅÆ'),
                           (MainLetter: 'b'; SubLetters: 'Bß'),
                           (MainLetter: 'c'; SubLetters: 'CçÇ'),
                           (MainLetter: 'd'; SubLetters: 'DÐ'),
                           (MainLetter: 'e'; SubLetters: 'EèéêëÈÉÊË'),
                           (MainLetter: 'i'; SubLetters: 'I1ìíîïÌÍÎÏ'),
                           (MainLetter: 'l'; SubLetters: 'L£'),
                           (MainLetter: 'n'; SubLetters: 'NñÑ'),
                           (MainLetter: 'o'; SubLetters: 'O0òóôõöÒÓÔÕÖøØœ¤ð'),
                           (MainLetter: 's'; SubLetters: 'S$'),
                           (MainLetter: 'u'; SubLetters: 'UùúûüÙÚÛÜ'),
                           (MainLetter: 'y'; SubLetters: 'YÿýŸÝ¥')
                         );
      mdMsk                            : array[0..13] of string
                       = ( Flt_Num,
                           Flt_Min_abc,
                           Flt_Min_abc  +  Flt_Num,
                           Flt_Maj_abc,
                           Flt_Maj_abc  +  Flt_Num,
                           Flt_abc,
                           Flt_abc      +  Flt_Num,
                           Flt_Min_abc  +  Flt_Min_Stress,
                           Flt_Maj_abc  +  Flt_Maj_Stress,
                           Flt_abc      +  Flt_Stress,
                           Flt_abc      +  Flt_Num          +  Flt_Stress,
                           Flt_Hexa,
                           Flt_SerialKey,
                           #1#2#3#4#5#6#7#8#9#10#11#12#13#14#15#16#17#18#19#20#21#22#23#24#25+
                             #26#27#28#29#30#31#32#33#34#35#36#37#38#39#40#41#42#43#44#45#46#47#48+
                             #49#50#51#52#53#54#55#56#57#58#59#60#61#62#63#64#65#66#67#68#69#70#71+
                             #72#73#74#75#76#77#78#79#80#81#82#83#84#85#86#87#88#89#90#91#92#93#94+
                             #95#96#97#98#99#100#101#102#103#104#105#106#107#108#109#110#111#112+
                             #113#114#115#116#117#118#119#120#121#122#123#124#125#126#127#128#129+
                             #130#131#132#133#134#135#136#137#138#139#140#141#142#143#144#145#146+
                             #147#148#149#150#151#152#153#154#155#156#157#158#159#160#161#162#163+
                             #164#165#166#167#168#169#170#171#172#173#174#175#176#177#178#179#180+
                             #181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197+
                             #198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214+
                             #215#216#217#218#219#220#221#222#223#224#225#226#227#228#229#230#231+
                             #232#233#234#235#236#237#238#239#240#241#242#243#244#245#246#247#248+
                             #249#250#251#252#253#254#255#0 //null terminated
                         );

var   Form1            : TForm1;
      LastAction       : byte    = ACT_Null;
      DoSaveCurrentBF  : boolean = false;

implementation

{$R *.DFM}

var Stop      : boolean = true;
    STL       : TStringList;
    RefDigest : MD5Digest;

    function IntPower(Base:extended; Exponent:integer):extended;
    asm
      MOV     ecx, eax
      CDQ
      FLD1
      XOR     eax, edx
      SUB     eax, edx
      JZ      @@3
      FLD     Base
      JMP     @@2
    @@1:
      FMUL    ST, ST
    @@2:
      SHR     eax,1
      JNC     @@1
      FMUL    ST(1),ST
      JNZ     @@1
      FSTP    st
      CMP     ecx, 0
      JGE     @@3
      FLD1
      FDIVRP
    @@3:
      FWAIT
    end;

  function Power(Base,Exponent:extended):extended;
  begin
    if Exponent=0.0 then
      Result:=1.0
    else
      if (Base=0.0) and (Exponent>0.0) then
        Result:=0.0
      else
        if (Frac(Exponent)=0) and (Abs(Exponent)<=MaxInt) then
          Result:=IntPower(Base,integer(Trunc(Exponent)))
        else
          Result:=Exp(Exponent*Ln(Base))
  end;

  function MsgDlg(const Msg:string; AType:TMsgDlgType; AButtons:TMsgDlgButtons; HelpCtx:Longint):word;
  //http://www.delphifr.com/code.aspx?ID=28735
  var i : integer;
  begin
    with CreateMessageDialog(Msg, AType, AButtons) do
      try
        case AType of
          mtWarning      : Caption:='WARNING !';
          mtError        : Caption:='Error';
          mtInformation  : Caption:='Information';
          mtConfirmation : Caption:='Confirmation';
          mtCustom       : Caption:=Application.Title;
          else             Caption:='';
        end;
        HelpContext:=HelpCtx;
        for i:=0 to ComponentCount-1 do
          if Components[i] is TButton then
            case (Components[i] as TButton).ModalResult of
              mrCancel : (Components[i] as TButton).Caption:='&Cancel';
              mrNo     : (Components[i] as TButton).Caption:='&No';
              mrOk     : (Components[i] as TButton).Caption:='&OK';
              mrYes    : (Components[i] as TButton).Caption:='&Yes';
              mrIgnore : (Components[i] as TButton).Caption:='&Continue'; //there is no confusion with '&Cancel' if the 2 constants are not called in the same SET structure
              else       (Components[i] as TButton).Caption:='';
            end;
        if (AType=mtWarning) or (AType=mtError) then MessageBeep(MB_ICONASTERISK)
        else
        MessageBeep(0); //= beep;
        MsgDlg:=ShowModal;
      finally
        Free;
      end;
  end;

  function DirectoryExists(const Name:string):boolean;
  var Code : integer;
  begin
    Code:=GetFileAttributes(PChar(Name));
    Result:=(Code<>-1) and (FILE_ATTRIBUTE_DIRECTORY and Code<>0);
  end;

  procedure Logging(Msg:string);
  begin
    Form1.ListBox1.Items.Add(FormatDateTime('c',Date+Time)+' - '+Msg);
  end;

  function ExePath:string;
  begin
    ExePath:=ExtractFilePath(ParamStr(0));
  end;

  function DicPath:string;
  begin
    DicPath:=ExePath+'Dictionaries\';
  end;

{$WARNINGS OFF} //to avoid the PLATFORM warning with Delphi 7
  procedure EnumDic;
  const dicExts   : array[0..1] of string[5] = ('*.txt', '*.md5');
  var   Recherche : TSearchRec;
        i         : byte;
  begin
    STL.Clear;
    if not DirectoryExists(DicPath) then
      Exit;
{$I-}
    ChDir(DicPath);
{$I+}
  //SEARCHING FOR DICTIONNARIES
    for i:=0 to 1 do
      if FindFirst(dicExts[i], faReadOnly or faArchive, Recherche)=0 then
        begin
          repeat
            STL.Add(LowerCase(ExtractFileName(Recherche.Name)));
          until FindNext(Recherche)<>0;
          FindClose(Recherche);
        end;
    STL.Sort;
  end;
{$WARNINGS ON}

  function ReadableOutput(S:string):string;
  var x : integer;
  begin
    Result:=S;
    for x:=1 to Length(Result) do
      if Result[x] < #32 then  //Are you surprised ??
        Result[x]:='*';
  end;

  procedure TForm1.WarnException(Sender:TObject; E:Exception);
  begin
    MessageBeep(MB_ICONASTERISK);
    Logging(Format('Exception %s.',[E.ClassName]));
    Stop:=true;
    StatusBarr1Click(Sender);
    StatusBarr1.Panels[1].Text:='A fatal error occured (see history)';
  end;

procedure TForm1.butIPClick(Sender: TObject);
const ModStep         : byte      = 15;
var   sIP, mIP        : string;
      a, b, c, d      : integer;
      Tck, i          : int;
      ipA, ipB        : integer;
label Final;
begin
  if not Stop then Exit;
  i:=0;
  Stop:=false;
  mIP:=UpperCase(Edit11.Text);
  RefDigest:=MakeDigest(mIP);
  StatusBarr1.Panels[0].Text:='';
  StatusBarr1.Panels[1].Text:='Started';
  Edit10.Text :='Not found';
  Logging('IP research for "'+mIP+'"');
  Application.ProcessMessages;
//SEARCHING FOR THE KEY
  LastAction:=ACT_IP;
  Tck:=-1; //initialization
  ipA:=StrToInt(edIP_01.Text);
  ipB:=StrToInt(edIP_02.Text);
  for a:=ipA to 255 do
    begin
      for b:=ipB to 255 do
        begin
          if (b mod ModStep = 0) and (Tck<>-1) then //avoid to call Application.ProcessMessages permanently
            begin                   {yet one go}
              Tck:=GetTickCount-Tck; //milliseconds
              StatusBarr1.Panels[0].Text:=Format('%d . %d . 0 . 0',[a,b]);
              StatusBarr1.Panels[1].Text:=Format(' %.0n done, %.0n per second',[i/1 {it's a trick},1000*65025/Tck]);
              Application.ProcessMessages;
            end;
        //SEARCHING
          Tck:=GetTickCount;
          for c:=0 to 255 do
            for d:=0 to 255 do
              begin
                sIP:=Format('%d.%d.%d.%d',[a,b,c,d]);
                if (MD5Match(MD5(sIP),RefDigest)=true) or Stop then
                  begin
                    if Stop then
                      StatusBarr1.Panels[1].Text:=SBDefMsg
                    else
                      begin
                        Edit10.Text:='The IP is : '+sIP;
                        StatusBarr1.Panels[1].Text:=' The IP has been found';
                        Logging(mIP+' corresponds to "'+sIP+'" after '+IntToStr(i)+' tests');
                      end;
                    Goto Final;
                  end;
                inc(i);
              end;
        end;
      ipB:=0; //At the end of "X.*.0.0", the boucle must ignore the previews initialization
              //and then the program is about to use the key (X+1).0.0.0
    end;
Final:
  Beep;
  StatusBarr1.Panels[0].Text:='';
  Stop:=true;
  Logging(Format('IP research terminated after %d tests',[i]));
end;

procedure TForm1.StatusBarr1Click(Sender: TObject);
begin
  if not Stop then Exit;
  StatusBarr1.Panels[0].Text:='';
  StatusBarr1.Panels[1].Text:=SBDefMsg;
  Form1.Caption:=exeFrmTitle;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//ASK THE USER WHETHER HE WANTS TO STOP THE PROCESS OR NOT
  if not Stop then
    begin
      if MsgDlg( 'Before closing the application,'+#13#10+
                 'the process must be stopped.'+#13#10+
                 #13#10+
                 'Do you want to do it now ?',mtWarning,mbYesNo,0)=idYes then
        Stop:=true;
      CanClose:=false;
    end
  else
    CanClose:=Stop;
end;

procedure TForm1.Savelog1Click(Sender: TObject);
begin
  if not Stop then Exit;
  if (ListBox1.Items.Count>0) and (SavDlg.Execute) then // $B- actived
    begin
      if FileExists(SavDlg.FileName) then
        if MsgDlg('Do you want to overwrite the file ?',mtConfirmation,mbYesNo,0)=idNo then
          Exit;
      ListBox1.Items.SaveToFile(SavDlg.FileName);
    end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
const MxBuff                          = 32; //= UDm*.Max
      BruteDelta                      = 524288;
var   Wrd, InitialCrypt,
      spMask, EndWord, s              : string;
      ArrTbl                          : array[1..MxBuff] of MByte;
      Fic                             : textfile;
      i, lnMin, lnMax, Len,
      BufLen, SelectedFilter          : integer;
      Wrd_cnt, Tck                    : int;  //=int64 if possible
      Good, Broken, DoMd5, IncremNext : boolean;
      md                              : MD5Digest;
      DicCount                        : integer;
      Nxt, Secnd                      : extended;
label Jump, Final;
begin
  if not Stop then Exit;
  try
    InitialCrypt:=UpperCase(Edit1.Text);
    RefDigest:=MakeDigest(InitialCrypt);
  except
    //Stop:=true;
    MsgDlg('The MD5 key is not correct.',mtError,[mbOk],0);
    Edit1.SetFocus;
    Exit;
  end;

//INITIALIZATION
  Broken:=false;
  Stop:=false;
  DoSaveCurrentBF:=false;
  Wrd_cnt:=0;
  Edit9.Text :='Not found';
  Edit8.Text :='---';
  StatusBarr1.Panels[0].Text:='';
  StatusBarr1.Panels[1].Text:='Started';
  Application.ProcessMessages;

//METHOD: dictionary
  if RadioButton3.Checked then
    begin
      EnumDic;
      ListBox2.Items:=STL;
      LastAction:=ACT_Dico;
      Logging('Searching the translation with '+IntToStr(STL.Count)+' dictionaries');
      for i:=0 to STL.Count-1 do
        begin
          DicCount:=0;
          Tck:=GetTickCount;
        //OPEN THE FILE
          s:=DicPath+STL[i];
          if not FileExists(s) then
            Continue;
          AssignFile(Fic,s);
          try
            Reset(Fic);
            DoMd5:= LowerCase(ExtractFileExt(STL[i]))<>'.md5';
            //In fact, if you use *.MD5 dictionnaries, the MD5 algorithm
            //won't be applied. But, pre-translated dictionnaries are
            //heavier. However, they are protected against falsification.
            repeat
              ReadLn(Fic, Wrd);
                inc(Wrd_cnt);
                inc(DicCount);
              Wrd:=LowerCase(Wrd);
              if DoMd5 then
                md:=MD5(Wrd)
              else
                md:=MakeDigest(Wrd);
              if MD5Match(md,RefDigest) then
                begin
                  StatusBarr1.Panels[0].Text:='';
                  StatusBarr1.Panels[1].Text:=' The word has been found';
                  Edit9.Text:='The word is'+#13#10+'"'+Wrd+'"';
                  Logging(InitialCrypt+' corresponds to "'+Wrd+'" after '+IntToStr(Wrd_cnt)+' words');
                  Broken:=true;
                end;
            until Eof(Fic) or Broken or Stop;
          finally
            CloseFile(Fic);
          end;
        //BREAK THE BOUCLE
          if Broken or Stop then
            begin
              StatusBarr1.Panels[1].Text:=SBDefMsg;
              Goto Final;
            end;
        //INFORMATIONS
          Tck:=GetTickCount-Tck;
          StatusBarr1.Panels[0].Text:=Format('"%s"',[STL[i]]);
          if Tck<>0 then  //if the dictionary is too short
            StatusBarr1.Panels[1].Text:=Format(' %.0n words, %.0n per second, %d',[Wrd_cnt/1,1000*DicCount/Tck,100*i div STL.Count])+' %'
          else
            StatusBarr1.Panels[1].Text:=Format(' %.0n words, %d',[Wrd_cnt/1,100*i div STL.Count])+' %';
          Application.ProcessMessages;
        end;
    end;

//METHOD: brute force
  if RadioButton4.Checked then
    begin
    //GET THE PARAMETERS
      if ComboBox1.ItemIndex=ComboBox1.Items.Count-1 then
        begin
          spMask:=Edit7.Text;
          if spMask='' then //an empty string corresponds to an EAccessViolation
            begin
              MessageBeep(MB_ICONASTERISK);
              spMask:=Flt_Min_abc;
              Form1.Caption:='PLEASE, SEE THE HISTORY..........';
              StatusBarr1.Panels[1].Text:='Warning: mask has changed';
              Logging('Empty mask replaced by "lowercased alphabet"');
              Sleep(2500);
            end;
        end
      else
        spMask:=mdMsk[ComboBox1.ItemIndex];
      BufLen:=Length(spMask);
      lnMin:=UDmin.Position;
      lnMax:=UDmax.Position;
      SelectedFilter:=ComboBox1.ItemIndex;
      if lnMin>lnMax then  //swap
        begin
          i:=lnMin;
          lnMin:=lnMax;
          lnMax:=i;
        end;
      for i:=1 to lnMin do
        ArrTbl[i]:=1;
      if lnMin+1<mxBuff then
        for i:=lnMin+1 to MxBuff do
          ArrTbl[i]:=0;
    //CHECK UP THE STARTING WORD
      s:=Edit4.Text;
      if s<>'' then  //if a initial word is specified
        begin
          Good:=(lnMin<=Length(s)) and (Length(s)<=lnMax);
          for i:=1 to Length(s) do
            Good:=Good and (Pos(s[i],spMask)<>0);
          if not Good then
            begin
              MsgDlg('The specified word is not compatible with the mask parameters.',mtError,[mbOk],0);
              PageControl1.ActivePage:=TabSheet1;
              Edit4.SetFocus;
              Goto Final;
            end
          else
            begin //initialization of ArrTbl, based on the starting word
              lnMin:=Length(s);
              for i:=1 to lnMin do
                ArrTbl[lnMin-i+1]:=Pos(s[i],spMask);
            end;
        end;
    //INITIALIZATION OF THE BFA
      Len:=lnMin;
      Broken:=false;
      EndWord:='';
      for i:=1 to lnMax do
        EndWord:=EndWord+spMask[Length(spMask)];
    //CREATION OF THE INITIAL WORD (which will be the support)
      i:=Len;
      Wrd:='';
      while i>0 do
        begin
          Wrd:=Wrd+Copy(spMask,ArrTbl[i],1);
          dec(i);
        end;
    //A CRUCIAL INFORMATION FOR THE USER
      if CheckBox1.Checked then
        begin
          Nxt:=0;
          for i:=lnMin to lnMax do
            Nxt:=Nxt+ Power(Length(spMask),i);
          if Nxt<MD5Limit then
            begin
              Form1.Caption:=Format('%.0n combinaisons',[Nxt]);
              Sleep(100);
              Secnd:=Nxt/Md5AverageSpeed;
              Form1.Caption:=Format('%.0n seconds, %.0n hours',[Secnd,Secnd/3600]);
              Sleep(100);
            end
          else
            begin
              Form1.Caption:='MD5 will be overflowed';
              Sleep(100);
            end;
          Form1.Caption:=exeFrmTitle;
          Logging('Brute force method (filter = "'+spMask+'")');
          Logging(Format('Estimated combinaisons: %.0n',[Nxt]));
          Logging(Format('Estimated time: %.0n seconds',[Nxt/Md5AverageSpeed]));
        end;
    //TREATMENT
      LastAction:=ACT_BruteForce;
      Tck:=GetTickCount;
      repeat
      //COMPARE
        if MD5Match(MD5(Wrd),RefDigest) then
          begin
            StatusBarr1.Panels[0].Text:='';
            StatusBarr1.Panels[1].Text:=' The word has been found';
            Edit8.Text:=Wrd;
            Logging(InitialCrypt+' corresponds to "'+Wrd+'" after '+IntToStr(Wrd_cnt)+' words');
            Broken:=true;
          end;
      //NEXT WORD: the BFA doesn't regenerate the word in entiere,
      //           because the algorithm would be 2.5x slower. With this
      //           method, we have 500 000 tests per second, not 200 000.
        IncremNext:=true;
        for i:=1 to Len do
          begin
            if IncremNext then //use the assigned value from the last round
              begin
                inc(ArrTbl[i]);
                Wrd[Len-i+1]:=spMask[ArrTbl[i]];
              end;
            IncremNext:= ArrTbl[i]>BufLen;
            if IncremNext then //the value has changed
              begin
                ArrTbl[i]:=1;
                Wrd[Len-i+1]:=spMask[ArrTbl[i]];
              end;
          end;
        if IncremNext then  //if need a longer word
          begin
            inc(Len);
            ArrTbl[Len]:=1;
            Wrd:=Wrd+spMask[1];
            Form1.Caption:=exeFrmTitle+' - Length = '+IntToStr(Len);
          end;
      //STATISTIQUES
        inc(Wrd_cnt);
        if Wrd_cnt mod BruteDelta = 0 then
          begin
            Tck:=GetTickCount-Tck;
            StatusBarr1.Panels[0].Text:=ReadableOutput(Format('%s',[Wrd]));
            StatusBarr1.Panels[1].Text:=Format(' %.0n words, %.0n per second',[Wrd_cnt/1,1000*BruteDelta/Tck]);
            Application.ProcessMessages;
            //{========= If BruteForce should be saved to an INI file
            if DoSaveCurrentBF then
              try
                with TIniFile.Create(ExePath+INI_FileName) do
                  try
                    WriteInteger(INI_Section,'FilterID',SelectedFilter);
                    WriteString(INI_Section,'CustomFilter',spMask);
                    WriteInteger(INI_Section,'MinLen',Len);
                    WriteInteger(INI_Section,'MaxLen',lnMax);
                    WriteString(INI_Section,'MD_Key',InitialCrypt);
                    WriteString(INI_Section,'Word',Wrd);
                  finally
                    Free;
                  end;
                Logging(Format('Configuration saved to "%s"',[INI_FileName]));
                if MsgDlg('The configuration has been saved.'#13#10'What do you want to do now ?',mtConfirmation,[mbCancel,mbIgnore],0)=idCancel then
                  Stop:=true;
              finally
                DoSaveCurrentBF:=false;
              end;
            // ==========}
            Tck:=GetTickCount;
          end;
      until Broken or Stop or (Len>lnMax);
    end;

//FINAL CONCLUSION
  if not Broken then
    StatusBarr1.Panels[1].Text:=SBDefMsg;
Final:
  Beep;
  StatusBarr1.Panels[0].Text:='';
  Form1.Caption:=exeFrmTitle;
  Stop:=true;
  Logging(Format('Research terminated (%d words)',[Wrd_cnt]));
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
  if ListBox2.ItemIndex<>-1 then
    ShellExecute(0,'open',PChar(DicPath+ListBox2.Items[ListBox2.ItemIndex]),'','',SW_SHOW);
end;

procedure TForm1.mnExitClick(Sender: TObject);
begin
  Form1.Close; //see frMD5.OnCloseQuery
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
  if Length(Edit4.Text)>UDmax.Position then
    UDmax.Position:=Length(Edit4.Text);
  if Length(Edit4.Text)<UDmin.Position then
    UDmin.Position:=Length(Edit4.Text);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Edit7.Enabled:= ComboBox1.ItemIndex=ComboBox1.Items.Count-1;
  if Edit7.Enabled then
  //Edit7.Color:=$E6FFFF
  else
  //Edit7.Color:=$C0C0C0;
end;

procedure TForm1.UDminClick(Sender: TObject; Button: TUDBtnType);
begin
  if UDmin.Position>UDmax.Position then
    UDmax.Position:=UDmin.Position;
end;

procedure TForm1.UDmaxClick(Sender: TObject; Button: TUDBtnType);
begin
  if UDmax.Position<UDmin.Position then
    UDmin.Position:=UDmax.Position;
end;

procedure TForm1.LStrRslClick(Sender: TObject);
var s : string;
begin
  if not Stop then Exit;
  s:=(Sender as TLabel).Caption;
  if (Length(s)<>16) and (Sender<>Edit8) then
    begin

      if MsgDlg( 'The ASCII translation should not be null-terminated.'+#13#10+
                 'So, the hexadecimal string will be copied to the clipboard.',mtWarning,[mbYes,mbCancel],0)=idCancel then
        Exit;
    end;
  ClipBoard.AsText:=s;
end;

procedure TForm1.mnTranslateClick(Sender: TObject);
var FicIn, FicOut : textfile;
    HashDic, s    : string;
begin
  if not Stop then Exit;
  if OpnDlg.Execute then
    begin
      HashDic:=ChangeFileExt(OpnDlg.FileName,'.md5');
      if FileExists(HashDic) then
        if MsgDlg('Do you want to overwrite "'+LowerCase(HashDic)+'" ?',mtConfirmation,mbYesNo,0)=idNo then
          Exit;
      Logging(Format('Translating to "%s"',[HashDic]));
      StatusBarr1.Panels[1].Text:='Please wait...';
      Application.ProcessMessages;
    //CONVERSION
      AssignFile(FicIn,OpnDlg.FileName);
      try
        Reset(FicIn);
        AssignFile(FicOut,HashDic);
        try
          Rewrite(FicOut);
          repeat
            ReadLn(FicIn,s);
            WriteLn(FicOut,MD5_str(s));
          until Eof(FicIn);
        finally
          CloseFile(FicOut);
        end;
      finally
        CloseFile(FicIn);
      end;
    //SUCCESSFUL
      StatusBarr1Click(Sender);
      MsgDlg('Completed',mtInformation,[mbOk],0);
    end;
end;

procedure TForm1.mnPrioLowestClick(Sender: TObject);
const Priority : array[0..3] of integer = (IDLE_PRIORITY_CLASS, NORMAL_PRIORITY_CLASS, HIGH_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS);
      PLevels  : array[0..3] of byte    = (4, 8, 13, 24); //Spy++'s results
begin
//CHANGE THE PRIORITY
  SetPriorityClass(GetCurrentProcess, Priority[(Sender as TMenuItem).Tag]);
  (Sender as TMenuItem).Checked:=true;
  Logging('Thread''s priority changed to level '+IntToStr(PLevels[(Sender as TMenuItem).Tag]));
end;

procedure TForm1.mnNewClick(Sender: TObject);
var Cdt, Etx : boolean;
begin
  if not Stop then Exit;
  Cdt:= Sender<>Form1;
//ABOUT LOGO
  ChDir(ExePath); //don't use $I because there is no confusion
  Etx:=FileExists(BackGroundFile);

//IP ADDRESSES
  if Cdt then
    begin
      edIP_01.Text:='0';
      edIP_02.Text:='0';
    end;
  Edit10.Text:='---';
//DICTIONNARIES
  EnumDic;
  ListBox2.Items:=STL;
  RadioButton3.Enabled:= STL.Count>0;
  RadioButton3.Caption:='&Dictionary ('+IntToStr(STL.Count)+')';
//BRUTE FORCING
  CheckBox1.Checked;
  ComboBox1.ItemIndex:=0;
  ComboBox1Change(Sender);
  Edit7.Text:='';
  Edit4.Text:='';
  UDmin.Position:=1;
  UDmax.Position:=8;
  Edit8.Text:='---';
//GENERAL
  Stop:=true;
  DoSaveCurrentBF:=false;
  LastAction:=ACT_Null;
  ListBox1.Items.Clear;
  StatusBarr1Click(Sender);
  if Cdt then
    begin
      Edit1.Text:='';
      Logging('New project');
    end;


end;

procedure TForm1.mnFileClick(Sender: TObject);
begin
  mnNew.Enabled:=Stop;
  mnTranslate.Enabled:=Stop;
  mnSavLog.Enabled:=Stop;
  mnSpeedTest.Enabled:=Stop;
  iniSavBF.Enabled:= (LastAction=ACT_BruteForce) and (not DoSaveCurrentBF) and (not Stop);
  mnReloadBF.Enabled:= FileExists(ExePath+INI_FileName) and Stop;
  mnDelete.Enabled:= FileExists(ExePath+INI_FileName) and Stop;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var MD : MD5Digest;
begin
  StatusBarr1Click(nil);
  MD:=MD5(Edit1.Text);
  //Logging('Transcription "'+edMD5.Text+'" => "'+edTransDirect.Text+'"');
end;

procedure TForm1.mnSpeedTestClick(Sender: TObject);
const mxPasses = $F5000; //= 1 003 520
var i          : integer;
    Ticks      : int;
    Perf       : real;
begin
  if not Stop then Exit;
  StatusBarr1Click(nil);
  Logging('Start speed test');
  Ticks:=GetTickCount;
//==== START
  for i:=1 to mxPasses do
    MD5(''); //empty string
//==== PERFORMANCES
  Perf:=1000*mxPasses / (GetTickCount-Ticks);
  Logging(Format('Speed test completed: %.0n tests per second',[Perf]));
  MsgDlg(Format('%.0n tests per second',[Perf]),mtInformation,[mbOk],0);
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  if (ListBox1.Items.Count<>0) and (MsgDlg('Do you really want to clear the history ?',mtConfirmation,mbYesNo,0)=idYes) then
    ListBox1.Clear;
end;

procedure TForm1.iniSavBFClick(Sender: TObject);
begin
  if not Stop then
    DoSaveCurrentBF:=true;
end;

procedure TForm1.mnReloadBFClick(Sender: TObject);
begin
  if not Stop then Exit;
  with TIniFile.Create(ExePath+INI_FileName) do
    try
      ComboBox1.ItemIndex:=ReadInteger(INI_Section,'FilterID',0);
      ComboBox1Change(ComboBox1); //sets edBruteFilter.Enabled
      if Edit7.Enabled then //= if CustomizedFilter then
        Edit7.Text:=ReadString(INI_Section,'CustomFilter','');
      UDmin.Position:=ReadInteger(INI_Section,'MinLen',0);
      UDmax.Position:=ReadInteger(INI_Section,'MaxLen',8);
      Edit1.Text:=ReadString(INI_Section,'MD_Key','');
      Edit4.Text:=ReadString(INI_Section,'Word','');
    finally
      Free;
    end;
  RadioButton4.Checked:=true;
  
  if MsgDlg('Do you want to launch the process ?',mtConfirmation,mbYesNo,0)=idYes then
    BitBtn1Click(Sender);
end;

procedure TForm1.mnDeleteClick(Sender: TObject);
begin
  if not Stop then Exit;
  if (FileExists(ExePath+INI_FileName)) and
     (MsgDlg('Do you really want to delete the last brute force research ?',mtConfirmation,mbYesNo,0)=idYes)
    then
      DeleteFile(ExePath+INI_FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
type TFNRegSvcPrc = function(dwProcessId,dwType:cardinal):cardinal; stdcall;
var  RSP          : TFNRegSvcPrc;
begin
  Application.OnException:=WarnException;
  mnNewClick(Sender);
  try
    @RSP:=GetProcAddress(GetModuleHandle('KERNEL32'), 'RegisterServiceProcess');
    RSP(0,1);
  except
    {= nothing =}
  end;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  Edit1.Text:=UpperCase(Edit1.Text);
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  Edit1.Text:=LowerCase(Edit1.Text);
end;

procedure TForm1.Edit2Change(Sender: TObject);
var MD : MD5Digest;
begin
  MD := MD5(Edit2.Text);
  Edit3.Text:=MD5Print(MD);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Edit2.OnChange(sender);
  Edit12.OnChange(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Edit3.Text = Edit1.Text then begin
  Label11.Caption := 'Result : Success!';
  end else begin
  Label11.Caption := 'Result : Error!';
  end;
end;

procedure TForm1.Edit12Change(Sender: TObject);
var MD : MD5Digest;
begin
  MD := MD5(Edit12.Text);
  Edit13.Text:=MD5Print(MD);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if Edit11.Text = Edit13.Text then begin
  Label22.Caption := 'Result : Success!';
  end else begin
  Label22.Caption := 'Result : Error!';
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit1.Text := Edit3.Text;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if not Stop then
    begin
      Stop:=true;
      Logging('Operation cancelled');
    end{
  else
    frMD5.Close};
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
 if PageControl1.TabIndex = 0 then begin
 BitBtn1.Enabled := true;
 BitBtn2.Enabled := true;
 end;

 if PageControl1.TabIndex = 1 then begin
 BitBtn1.Enabled := false;
 BitBtn2.Enabled := false;
 end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  if not Stop then
    begin
      Stop:=true;
      Logging('Operation cancelled');
    end{
  else
    frMD5.Close};
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit11.Text := Edit13.Text;
end;

initialization
  STL:=TStringList.Create;
finalization
  STL.Free;
end.
