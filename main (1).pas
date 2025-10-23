program JogoVelhaConsole;
uses
  Crt;

const
  TAMANHO_TABULEIRO = 3;

type
  Tabuleiro = array[1..TAMANHO_TABULEIRO, 1..TAMANHO_TABULEIRO] of Char;

procedure Finalizar;
begin
  WriteLn('Pressione ENTER para finalizar!');
  ReadLn;
end;

procedure TrocarSimbolo(var simbolo: Char);
begin
  if simbolo = 'X' then
    simbolo := 'O'
  else
    simbolo := 'X';
end;

procedure InicializarTabuleiro(var tabuleiro: Tabuleiro);
var
  i, j: Integer;
begin
  for i := 1 to TAMANHO_TABULEIRO do
    for j := 1 to TAMANHO_TABULEIRO do
      tabuleiro[i, j] := ' ';
end;

procedure ExibirTabuleiro(const tabuleiro: Tabuleiro);
var
  i, j: Integer;
begin
  ClrScr;
  WriteLn('*********** JOGO DA VELHA ***************');
  WriteLn('********** Ivanete Aparecida ************');
  WriteLn;
  WriteLn('-------------');
  for i := 1 to TAMANHO_TABULEIRO do
  begin
    Write('| ');
    for j := 1 to TAMANHO_TABULEIRO do
    begin
      Write(tabuleiro[i, j], ' | ');
    end;
    WriteLn;
    WriteLn('-------------');
  end;
  WriteLn;
end;

function JogadaValida(const tabuleiro: Tabuleiro; linha, coluna: Integer): Boolean;
begin
  if (linha >= 1) and (linha <= TAMANHO_TABULEIRO) and
     (coluna >= 1) and (coluna <= TAMANHO_TABULEIRO) and
     (tabuleiro[linha, coluna] = ' ') then
    JogadaValida := True
  else
    JogadaValida := False;
end;

function VerificarVitoria(const tabuleiro: Tabuleiro; simbolo: Char): Boolean;
var
  i: Integer;
begin
  // Verificar linhas
  for i := 1 to TAMANHO_TABULEIRO do
    if (tabuleiro[i, 1] = simbolo) and (tabuleiro[i, 2] = simbolo) and (tabuleiro[i, 3] = simbolo) then
    begin
      VerificarVitoria := True;
      Exit;
    end;

  // Verificar colunas
  for i := 1 to TAMANHO_TABULEIRO do
    if (tabuleiro[1, i] = simbolo) and (tabuleiro[2, i] = simbolo) and (tabuleiro[3, i] = simbolo) then
    begin
      VerificarVitoria := True;
      Exit;
    end;

  // Verificar diagonais
  if ((tabuleiro[1, 1] = simbolo) and (tabuleiro[2, 2] = simbolo) and (tabuleiro[3, 3] = simbolo)) or
     ((tabuleiro[1, 3] = simbolo) and (tabuleiro[2, 2] = simbolo) and (tabuleiro[3, 1] = simbolo)) then
  begin
    VerificarVitoria := True;
    Exit;
  end;

  VerificarVitoria := False;
end;

function TabuleiroCompleto(const tabuleiro: Tabuleiro): Boolean;
var
  i, j: Integer;
begin
  for i := 1 to TAMANHO_TABULEIRO do
    for j := 1 to TAMANHO_TABULEIRO do
      if tabuleiro[i, j] = ' ' then
      begin
        TabuleiroCompleto := False;
        Exit;
      end;
  TabuleiroCompleto := True;
end;

procedure EfetuarJogadaIA(var tabuleiro: Tabuleiro);
var
  linha, coluna: Integer;
begin
  repeat
    linha := Random(TAMANHO_TABULEIRO) + 1;
    coluna := Random(TAMANHO_TABULEIRO) + 1;
  until JogadaValida(tabuleiro, linha, coluna);
  tabuleiro[linha, coluna] := 'O';
end;

procedure Jogar(var tabuleiro: Tabuleiro);
var
  linha, coluna: Integer;
  jogadorAtual: Char;
begin
  Randomize;
  InicializarTabuleiro(tabuleiro);
  jogadorAtual := 'X';

  while True do
  begin
    ExibirTabuleiro(tabuleiro);

    if jogadorAtual = 'X' then
    begin
      WriteLn('*** SUA JOGADA ***');
      Write('Informe a linha (1-3): ');
      ReadLn(linha);
      Write('Informe a coluna (1-3): ');
      ReadLn(coluna);

      if JogadaValida(tabuleiro, linha, coluna) then
      begin
        tabuleiro[linha, coluna] := jogadorAtual;
        TrocarSimbolo(jogadorAtual);
      end
      else
      begin
        WriteLn('*** Jogada inválida! ***');
        WriteLn('Pressione ENTER para tentar novamente...');
        ReadLn;
      end;
    end
    else
    begin
      WriteLn('Vez do computador (O)...');
      EfetuarJogadaIA(tabuleiro);
      TrocarSimbolo(jogadorAtual);
    end;

    // Verificações de vitória
    if VerificarVitoria(tabuleiro, 'X') then
    begin
      ExibirTabuleiro(tabuleiro);
      WriteLn('🎉 Você venceu!');
      Finalizar;
      Exit;
    end
    else if VerificarVitoria(tabuleiro, 'O') then
    begin
      ExibirTabuleiro(tabuleiro);
      WriteLn('💻 O computador venceu!');
      Finalizar;
      Exit;
    end
    else if TabuleiroCompleto(tabuleiro) then
    begin
      ExibirTabuleiro(tabuleiro);
      WriteLn('😐 Partida empatada!');
      Finalizar;
      Exit;
    end;
  end;
end;

var
  vtabuleiro: Tabuleiro;
begin
  Jogar(vtabuleiro);
end.