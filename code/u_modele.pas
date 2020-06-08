unit u_modele;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_loaddataset;
type
Tmodele = class(TMySQL)
   private
   { private declarations }
   public
   { public declarations }
   procedure open;
   function  inscrit_liste_tous : TLoadDataSet;
   function  inscrit_liste_filiere (code : string) : TLoadDataSet;
   function  inscrit_liste_etudiant (id ,nom : string) : TLoadDataSet;
   function  inscrit_num (num : string) : TLoadDataSet;
   function  inscrit_notes (num : string) : TLoadDataSet;
   function  recherche_filiere (code_fil : string) : String;
   procedure inscrit_delete (id_inf : string);
   procedure inscrit_insert (id, civ, nom, prenom, adresse, cp, ville, portable, telephone, mel, code_fil : string);
   procedure inscrit_update (id, civ, nom, prenom, adresse, cp, ville, portable, telephone, mel : string);
   procedure inscrit_notes_delete (id_inf : string);
   procedure close;
end;

var
     modele: Tmodele;
implementation

procedure Tmodele.open;
begin
      Bd_open ('devbdd.iutmetz.univ-lorraine.fr', 0
		, 'morize7u_bdnote'
		, 'morize7u_appli'
		, 'M*Vincent57*'
		, 'mysqld-5', 'libmysql64.dll');
end;

procedure Tmodele.close;
begin
      Bd_close;
end;

function Tmodele.inscrit_liste_tous : TLoadDataSet;
begin
     result := load('sp_inscrit_liste_tous',[]);
end;

function Tmodele.inscrit_liste_etudiant (id ,nom : string) : TLoadDataSet;
begin
     result := load('sp_inscrit_liste_etudiant',[id,nom]);
end;

function Tmodele.inscrit_liste_filiere (code : string ) : TLoadDataSet;
begin
      result := load('sp_inscrit_liste_filiere',[code]);
end;

function Tmodele.inscrit_num (num : string) : TLoadDataSet;
begin
     result := load('sp_inscrit_num',[num]);
end;

function Tmodele.inscrit_notes (num : string) : TLoadDataSet;
begin
     result := load('sp_inscrit_notes',[num]);
end;

function Tmodele.recherche_filiere (code_fil : string) : String;
begin
     load('sp_inscrit_recherche_filiere',[code_fil], result);
end;

procedure Tmodele.inscrit_delete (id_inf : string);
begin
     exec('sp_inscrit_delete',[id_inf]);
end;

procedure Tmodele.inscrit_insert (id, civ, nom, prenom, adresse, cp, ville, portable, telephone, mel, code_fil : string);
begin
     exec('sp_inscrit_insert',[id, civ, nom, prenom, adresse, cp, ville, portable, telephone, mel, code_fil]);
end;

procedure Tmodele.inscrit_update (id, civ, nom, prenom, adresse, cp, ville, portable, telephone, mel : string);
begin
     exec('sp_inscrit_update',[id],[civ, nom, prenom, adresse, cp, ville, portable, telephone, mel]);
end;

procedure Tmodele.inscrit_notes_delete (id_inf : string);
begin
     exec('sp_inscrit_notes_delete',[id_inf]);
end;

begin
     modele := TModele.Create;
end.

