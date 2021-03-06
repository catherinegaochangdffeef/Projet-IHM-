unit u_select_inscrit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tf_select_inscrit }

  Tf_select_inscrit = class(TForm)
    btn_rechercher: TButton;
    edt_num: TEdit;
    edt_nom: TEdit;
    edt_code: TEdit;
    lbl_num: TLabel;
    lbl_nom: TLabel;
    lbl_code: TLabel;
    pnl_rechercher: TPanel;
    pnl_filiere_edit: TPanel;
    pnl_filiere_btn: TPanel;
    pnl_filiere: TPanel;
    pnl_etudiant_edit: TPanel;
    pnl_tous_edit: TPanel;
    pnl_etudiant_btn: TPanel;
    pnl_tous_btn: TPanel;
    pnl_etudiant: TPanel;
    pnl_titre: TPanel;
    pnl_choix: TPanel;
    pnl_tous: TPanel;
    procedure btn_rechercherClick(Sender: TObject);
    procedure Init;
    procedure  NonSelectionPanel (pnl : TPanel);
    procedure  AucuneSelection;
    procedure  pnl_choix_btnClick (Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_select_inscrit: Tf_select_inscrit;

implementation

{$R *.lfm}

uses u_feuille_style, u_list_inscrit, u_modele;
var
  pnl_actif : TPanel;
{ Tf_select_inscrit }

procedure Tf_select_inscrit.Init;
begin
  style.panel_defaut(pnl_choix);
  style.panel_selection(pnl_titre);
  style.panel_defaut(pnl_rechercher);
  pnl_choix_btnClick(pnl_tous_btn);
end;

procedure Tf_select_inscrit.btn_rechercherClick(Sender: TObject);
begin
   btn_rechercher.visible := false;
   pnl_actif.enabled := false;
   if  pnl_tous_edit.Visible  then
    f_list_inscrit.affi_data(modele.inscrit_liste_tous)
else if  pnl_filiere_edit.visible  then
     f_list_inscrit.affi_data(modele.inscrit_liste_filiere(edt_code.text))
else if  pnl_etudiant_edit.visible  then
     if edt_num.text<>'' then
     f_list_inscrit.affi_data(modele.inscrit_liste_etudiant(edt_num.text,edt_nom.text))
     else f_list_inscrit.affi_data(modele.inscrit_liste_etudiant('0',edt_nom.text))
end;

procedure   Tf_select_inscrit.pnl_choix_btnClick (Sender : TObject);
var
   pnl : TPanel;
begin
   AucuneSelection;
   pnl := TPanel(Sender);
   style.panel_selection (pnl);
   pnl	:= TPanel(pnl.Parent);	style.panel_selection (pnl);
   pnl	:= TPanel(f_select_inscrit.FindComponent(pnl.name +'_edit'));
   style.panel_selection (pnl);
   pnl.show;
   pnl_actif := pnl;     pnl_actif.enabled := true;
   btn_rechercher.visible := true;
end;

procedure   Tf_select_inscrit.AucuneSelection;
begin
	NonSelectionPanel (pnl_tous);		NonSelectionPanel (pnl_etudiant);
	NonSelectionPanel (pnl_filiere);
end;

procedure  Tf_select_inscrit.NonSelectionPanel (pnl : TPanel);
var
	pnl_enfant : TPanel;
begin
	style.panel_defaut(pnl);
	pnl_enfant	:= TPanel(f_select_inscrit.FindComponent(pnl.name +'_btn'));
	style.panel_bouton(pnl_enfant);
	pnl_enfant	:= TPanel(f_select_inscrit.FindComponent(pnl.name +'_edit'));
	pnl_enfant.Hide;
end;
end.

