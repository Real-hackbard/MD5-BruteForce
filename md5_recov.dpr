program md5_recov;

uses
  Forms,
  md5rev in 'md5rev.pas' {Form1},
  md5_call in 'md5_call.pas';

{$E exe}

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MD5 Recovery Tool';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

