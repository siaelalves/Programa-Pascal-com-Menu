Program Locadora ;

type
  filmes=record
      reg : integer;
	    nome : string;
	    dur : integer;
	    ano : integer;
	    categoria : string;
  	  disponivel : string;
	  end;
	                    	
  

var
  opcao : integer;
  arq_dados : text;
  filme : filmes;
  
  lista : string;
  
  lista_p : array[1..7] of string;
  p : integer;
  
  n : string;
  i : integer;
  o : boolean;
  q : integer;

//Exibe o nome da locadora		
Procedure Cabecalho;
begin
  textcolor(LIGHTGREEN);
  writeln('Locadora Monsenhor Pedro');
  writeln('------------------------');
  writeln('    Melhores filmes pelo');
  writeln('            menor preço!');
  writeln();
end;


//Determina o número que será usado para o registro do próximo vídeo
Function Valor_do_Registro : integer;
var
  r : integer;

begin
  r := 1;
  assign(arq_dados,'filmes.txt');
  reset(arq_dados);
  
  repeat
    
		//Faz a leitura do arquivo filmes.txt
    //A variável r é somada a ela mesma para saber quantas linhas o arquivo tem
    readln(arq_dados,lista);
	  r := r + 1;
	until (eof(arq_dados)=true);
	
	close(arq_dados);
	
	//Pega o número de linhas do arquivo filmes.txt e divide por 7,
	//porque cada cadastro ocupa 7 linhas no arquivo.
	Valor_do_Registro := r DIV 7;	
end;

Procedure Valores_padrao;
begin
  filme.reg := Valor_do_Registro;
end;

Procedure Cadastrar;
begin
  clrscr;
  Valores_padrao;
  Cabecalho;
  textcolor(YELLOW);
  writeln('CADASTRO DE FILMES');
  writeln('------------------');
  textcolor(WHITE);
	writeln('Nº do registro: ', filme.reg+1);
	writeln('Nome do filme : ');
	writeln('Duração       :    ', 'min');
	writeln('Ano           : ');
	writeln('Categoria     : ');
	writeln('Disponível em : ');
	
	textcolor(LIGHTGRAY);
	//gotoxy - coloca o cursor na posição (coluna x linha)
	gotoxy(17,9);
	readln(filme.nome);
	
	gotoxy(17,10);
	readln(filme.dur);
	
	gotoxy(17,11);
	readln(filme.ano);
	
	gotoxy(17,12);
	readln(filme.categoria);
	
	gotoxy(17,13);
	readln(filme.disponivel);
	
	//Abre o arquivo
	assign(arq_dados, 'filmes.txt' ) ;
	
	append(arq_dados);
	writeln(arq_dados,'         # ',filme.reg+1);
	writeln(arq_dados,'     Nome: ',filme.nome);
	writeln(arq_dados,'  Duração: ',filme.dur,' min');
	writeln(arq_dados,'      Ano: ',filme.ano);
	writeln(arq_dados,'Categoria: ',filme.categoria);
	writeln(arq_dados,'  Dispon.: ',filme.disponivel);
	writeln(arq_dados,'-----------');
	close(arq_dados);
	
	filme.reg := filme.reg + 1;
end;     

Procedure Buscar_filme;
begin
  clrscr;
  Cabecalho;
  textcolor(YELLOW);
  writeln('PESQUISA');
  writeln('--------');
  o := false;
  p := 0;
  q := 0;
  
  textcolor(YELLOW);
  write('Nome do filme: ');
  readln(n);
  
  assign(arq_dados,'filmes.txt');
  reset(arq_dados);
  
  repeat
    repeat
        readln(arq_dados,lista);
        lista_p[p + 1] := lista;
        p := p + 1;
        
    until(p=7);
    
    p := 0;
	
    if upcase(lista_p[2]) = upcase('     Nome: ') + upcase(n) then
      begin
        writeln();
        for p := 1 to 7 do
          begin
            textcolor(WHITE);
            writeln(lista_p[p]);
          end;
        q := q + 1;
				textcolor(YELLOW);    
        if q = 1 then write('A pesquisa foi finalizada. ', q, ' resultado foi encontrado.');
        if q > 1 then write('A pesquisa foi finalizada. ', q, ' resultados foram encontrados.');
        o := true
        
      end;
  until(eof(arq_dados)=true) or (o=true);
  
  if q = 0 then
	  begin
	    writeln();
	    textcolor(YELLOW);
		  write('A pesquisa foi finalizada. O FILME NÃO ESTÁ CADASTRADO.');
		end;  
  
  close(arq_dados);
  readkey();
end;

Procedure Buscar_filme_por_categoria;
begin
  clrscr;
  Cabecalho;
  textcolor(YELLOW);
  writeln('PESQUISA POR CATEGORIA');
  writeln('--------');
  o := false;
  p := 1;
  q := 0;
  
  write('Categoria: ');
  readln(n);
  
  assign(arq_dados,'filmes.txt');
  reset(arq_dados);
  
  repeat
    for p := 1 to 7 do
      begin
        readln(arq_dados,lista);
        lista_p[p] := lista;
      end;  
    
    p:=1;
    
		if upcase(lista_p[5]) = upcase('Categoria: ' + n) then
    begin
      textcolor(WHITE);
      writeln();
      for p := 1 to 7 do
        begin
          writeln(lista_p[p]);
        end;
      q := q + 1;
    end;
		
		p:=1;    
  until(eof(arq_dados)=true);
  
  writeln();
  textcolor(YELLOW);
  if q = 1 then write('A pesquisa foi finalizada. ', q, ' resultado foi encontrado.');
  if q = 0 then write('A pesquisa foi finalizada. NÃO EXISTEM FILMES CADASTRADOS.');
  if q > 1 then write('A pesquisa foi finalizada. ', q, ' resultados foram encontrados.');
  close(arq_dados);
  readkey();
end;

Procedure Todos_os_filmes;
begin
  clrscr;
	Cabecalho;
	q := 0;
	textcolor(YELLOW);
  writeln('LISTA DE TODOS OS NOSSOS FILMES');
  writeln('-------------------------------');
  
  assign(arq_dados,'filmes.txt');
  reset(arq_dados);
  
  textcolor(WHITE);
  repeat
    readln(arq_dados,lista);
    writeln(lista);
    if lista = '-----------' then readkey();
    q := q + 1;
  until(eof(arq_dados)=true);

  close(arq_dados);
  
  textcolor(YELLOW);
  writeln('-------------------------------');
  if q = 1 then writeln('Este é o único filme que dispomos.');
  if q > 0 then writeln('Estes são todos os nossos títulos.');
  if q = 0 then writeln('NÃO EXISTEM FILMES CADASTRADOS.');
  writeln();
  readln();
end;



Begin
repeat
  Cabecalho;
  textcolor(YELLOW);
  writeln('Escolha uma das opções: ');
  writeln();
  textcolor(WHITE);
  writeln('1. Cadastrar filmes');
  writeln('2. Buscar por filme');
  writeln('3. Buscar filme(s) por categoria');
  writeln('4. Listar todos os filmes cadastrados');
  writeln('5. Finalizar');
  writeln;
  
  gotoxy(25,6);
  textcolor(WHITE);
	readln(opcao);
  
  if opcao = 1 then
    begin
      Cadastrar;
    end;
  if opcao = 2 then
    begin
      Buscar_filme;
    end;
  if opcao = 3 then
    begin
      Buscar_filme_por_categoria;
    end;
  if opcao = 4 then
    begin
      Todos_os_filmes;
    end;
    
  clrscr;
until(opcao=5);
    
End.