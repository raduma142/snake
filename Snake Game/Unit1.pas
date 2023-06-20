unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    LabelSnake: TLabel;
    LabelPlay: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabelPlayClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  length, v, lastv: integer;
  can_ch_v: boolean;
  snake: array[1..400] of array[1..2] of integer;

  food: array[1..2] of integer; //Еда

implementation

uses Math;

{$R *.dfm}

//Генерация корма
procedure GenerateFood;
var
  ok, i: integer;
begin
  ok := 1;
  food[1] := RandomRange(1, 20) - 1;
  food[2] := RandomRange(1, 20) - 1;

  for i := 1 to length do
    if (snake[i][1] = food[1]) and (snake[i][2] = food[2]) then ok := 0;

  if ok <> 1 then GenerateFood;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  i, j: integer;
begin
  MainForm.Canvas.Brush.Color := clBlack;
  MainForm.Canvas.Pen.Color := clTeal;
  MainForm.Canvas.FillRect(Rect(0, 0, 400, 400));

  //Проверка движения
  Case v of
  1: if lastv = 3 then v := lastv;
  2: if lastv = 4 then v := lastv;
  3: if lastv = 1 then v := lastv;
  4: if lastv = 2 then v := lastv;
  end;
  lastv := v;

  //Смещение
  for i := length downto 2 do
  begin
    snake[i][1] := snake[i - 1][1];
    snake[i][2] := snake[i - 1][2];
  end;
  Case v of
  1: dec(snake[1][1]);
  2: dec(snake[1][2]);
  3: inc(snake[1][1]);
  4: inc(snake[1][2]);
  end;

  //Съедание корма
  if (snake[1][1] = food[1]) and (snake[1][2] = food[2]) then
  begin
    GenerateFood;
    inc(length);
    snake[length][1] := snake[length - 1][1];
    snake[length][2] := snake[length - 1][2];
  end;

  //Выход за карту
  if snake[1][1] < 0 then snake[1][1] := 19;
  if snake[1][1] >= 20 then snake[1][1] := 0;
  if snake[1][2] < 0 then snake[1][2] := 19;
  if snake[1][2] >= 20 then snake[1][2] := 0;

  //Отображение
  for i := 0 to 20 do
  begin
    MainForm.Canvas.MoveTo(0, i * 20);
    MainForm.Canvas.LineTo(400, i * 20);
    MainForm.Canvas.MoveTo(i * 20, 0);
    MainForm.Canvas.LineTo(i * 20, 400);
  end;

  MainForm.Canvas.Brush.Color := clLime;
  MainForm.Canvas.Pen.Color := clLime;
  for i := 1 to length do
    MainForm.Canvas.Rectangle(Rect(snake[i][1]*20, snake[i][2]*20, snake[i][1]*20 + 20, snake[i][2]*20 + 20));
  MainForm.Canvas.Ellipse(food[1] * 20 + 5, food[2] * 20 + 5, food[1] * 20 + 15, food[2] * 20 + 15);

  can_ch_v := True;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;

  length := 3;
  snake[1][1] := 3;
  snake[1][2] := 1;

  snake[2][1] := 2;
  snake[2][2] := 1;

  snake[3][1] := 2;
  snake[3][2] := 2;

  v := 3;
  lastv := 3;
  can_ch_v := True;
  randomize;
  GenerateFood;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lastv := v;

  if can_ch_v then
  begin
    case Key of
      37: v := 1; //L
      38: v := 2; //U
      39: v := 3; //R
      40: v := 4; //D
    end;
  end;

  can_ch_v := False;
end;

procedure TMainForm.LabelPlayClick(Sender: TObject);
begin
  LabelPlay.Hide;
  LabelSnake.Hide;
  Timer1.Enabled := True;
end;

end.






