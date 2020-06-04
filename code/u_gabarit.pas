unit u_gabarit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls;

type

  { Tf_gabarit }

  Tf_gabarit = class(TForm)
    item_accueil: TMenuItem;
    item_quitter: TMenuItem;
    item_liste: TMenuItem;
    item_archive: TMenuItem;
    item_inscrit: TMenuItem;
    item_filiere: TMenuItem;
    item_filiere_liste: TMenuItem;
    item_statistiques: TMenuItem;
    item_archive_n2: TMenuItem;
    item_archive_n1: TMenuItem;
    Label1: TLabel;
    mnu_main: TMainMenu;
    pnl_ariane: TPanel;
    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_info: TPanel;
    procedure FormShow(Sender: TObject);
    procedure item_quitterClick(Sender: TObject);
    procedure mnu_item_Click(Sender: TObject);
    procedure choix_item_liste;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_gabarit: Tf_gabarit;

implementation

{$R *.lfm}

{ Tf_gabarit }

Uses  u_feuille_style, u_list_inscrit, u_select_inscrit, u_detail_inscrit;


procedure Tf_gabarit.mnu_item_Click(Sender: TObject);
var
   item : TMenuItem;
begin
   pnl_selection.show;

   pnl_ariane.Caption := '';
   item := TmenuItem(Sender);
   repeat
         pnl_ariane.Caption := ' >' + item.caption +pnl_ariane.Caption;
         item := item.parent;
   until item.parent = nil;
   item := TmenuItem(Sender);
   if item=item_liste then choix_item_liste;
end;

procedure Tf_gabarit.choix_item_liste;
begin
     f_list_inscrit.borderstyle	:= bsNone;
     f_list_inscrit.parent		:= pnl_travail;
     f_list_inscrit.align		:= alClient;
     f_list_inscrit.init;
     f_list_inscrit.show ;

      f_select_inscrit.borderstyle := bsNone;
      f_select_inscrit.parent          := pnl_selection;
      f_select_inscrit.align            := alClient;
      f_select_inscrit.init;
      f_select_inscrit.show;

      f_detail_inscrit.borderstyle := bsNone;
      f_detail_inscrit.parent      := pnl_travail;
      f_detail_inscrit.align       := alClient
end;

procedure Tf_gabarit.FormShow(Sender: TObject);
begin
   style.panel_selection (pnl_ariane);
   style.panel_defaut    (pnl_selection);
   style.panel_travail   (pnl_travail);
   style.panel_defaut    (pnl_info);
   f_gabarit.width := 1200;
   f_gabarit.height :=  800;
   pnl_ariane.caption:= ' >' + item_accueil.caption
end;


procedure Tf_gabarit.item_quitterClick(Sender: TObject);
begin
   close;
end;



end.

