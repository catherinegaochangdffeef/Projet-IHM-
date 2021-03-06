unit u_detail_inscrit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids, ValEdit;

type

  { Tf_detail_inscrit }

  Tf_detail_inscrit = class(TForm)
    btn_valider: TButton;
    btn_annuler: TButton;
    btn_retour: TButton;
    cbx_civ: TComboBox;
    edt_filiere: TEdit;
    edt_telephone: TEdit;
    edt_portable: TEdit;
    edt_mel: TEdit;
    edt_adresse: TEdit;
    edt_cp: TEdit;
    edt_ville: TEdit;
    edt_num: TEdit;
    edt_nom: TEdit;
    edt_prenom: TEdit;
    lbl_releve: TLabel;
    lbl_filiere_court: TLabel;
    lbl_filiere_long: TLabel;
    lbl_filiere_erreur: TLabel;
    lbl_filiere: TLabel;
    lbl_telephone_erreur: TLabel;
    lbl_mel_erreur: TLabel;
    lbl_telephone: TLabel;
    lbl_portable: TLabel;
    lbl_mel: TLabel;
    lbl_contact: TLabel;
    lbl_adresse: TLabel;
    lbl_adresse_erreur: TLabel;
    lbl_ville_erreur: TLabel;
    lbl_cp_erreur: TLabel;
    lbl_num_erreur: TLabel;
    lbl_nom_erreur: TLabel;
    lbl_prenom_erreur: TLabel;
    lbl_prenom: TLabel;
    lbl_nom: TLabel;
    lbl_num: TLabel;
    lbl_ident: TLabel;
    pnl_releve_titre: TPanel;
    pnl_releve_list: TPanel;
    pnl_releve: TPanel;
    pnl_filiere: TPanel;
    pnl_contact: TPanel;
    pnl_adresse: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_btn: TPanel;
    pnl_titre: TPanel;
    procedure btn_annulerClick(Sender: TObject);
    procedure btn_retourClick(Sender: TObject);
    procedure btn_validerClick(Sender: TObject);
    procedure edt_adresseExit(Sender: TObject);
    procedure edt_cpExit(Sender: TObject);
    procedure edt_melExit(Sender: TObject);
    procedure edt_nomExit(Sender: TObject);
    procedure edt_numExit(Sender: TObject);
    procedure edt_portableExit(Sender: TObject);
    procedure edt_prenomExit(Sender: TObject);
    procedure edt_telephoneExit(Sender: TObject);
    procedure edt_villeExit(Sender: TObject);
    procedure edt_filiereExit(Sender: TObject);
    procedure init ( idinf : string; affi : boolean);
    procedure detail   ( idinf : string);
    procedure edit      ( idinf : string);
    procedure add;
    procedure delete  ( idinf : string);
    procedure edt_Enter (Sender : TObject );

  private
    { private declarations }
    procedure affi_page;
    function  affi_erreur_saisie     (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
  public
    { public declarations }
  end;

var
  f_detail_inscrit: Tf_detail_inscrit;

implementation

{$R *.lfm}

 uses u_feuille_style, u_list_inscrit, u_releve_list, u_modele, u_loaddataset;
{ Tf_detail_inscrit }
Var
   oldvaleur  : string;	// utilisée dans la modification pour comparer l’ancienne valeur avec la saisie
   id  : string;	// variable active dans toute l'unité, contenant l'id inscription affichée

procedure	Tf_detail_inscrit.Init   ( idinf : string;	affi : boolean);
//  ajout nouvelle inscription : id est vide
// affichage détail d'une inscription : affi est vrai sinon affi est faux
begin
   style.panel_travail	(pnl_titre);
   style.panel_travail	(pnl_btn);
   style.panel_travail	(pnl_detail);
	style.panel_travail (pnl_ident);
	        style.label_titre  (lbl_ident);
		style.label_erreur (lbl_num_erreur);		lbl_num_erreur.caption    :=  ' ' ;
		style.label_erreur (lbl_nom_erreur);		lbl_nom_erreur.caption    :=  ' ' ;
		style.label_erreur (lbl_prenom_erreur);		lbl_prenom_erreur.caption    :=  ' ' ;
        style.panel_travail (pnl_adresse);
		style.label_titre  (lbl_adresse);
		style.label_erreur (lbl_adresse_erreur);	lbl_adresse_erreur.caption  :=  ' ' ;
		style.label_erreur (lbl_ville_erreur);		lbl_ville_erreur.caption  :=  ' ' ;
		style.label_erreur (lbl_cp_erreur);		lbl_cp_erreur.caption  :=  ' ' ;
        style.panel_travail (pnl_contact);
		style.label_titre  (lbl_contact);
		style.label_erreur (lbl_telephone_erreur);	lbl_telephone_erreur.caption :=  ' ' ;
		style.label_erreur (lbl_mel_erreur);		lbl_mel_erreur.caption :=  ' ' ;
        style.panel_travail (pnl_filiere);
		style.label_titre  (lbl_filiere);
		style.label_erreur (lbl_filiere_erreur);	lbl_filiere_erreur.caption  :=  ' ' ;
                lbl_filiere_court.caption  :=  ' ' ;
                lbl_filiere_long.caption  :=  ' ' ;
        style.panel_travail (pnl_releve);
	style.panel_travail (pnl_releve_list);
		style.label_titre  (lbl_filiere);
                style.label_titre  (lbl_releve);

// initialisation identification
   edt_num.clear;
   edt_num.ReadOnly	:=affi;
   lbl_num_erreur.caption    :=  ' ' ;
   edt_nom.clear;
   edt_nom.ReadOnly	:=affi;
   cbx_civ.ReadOnly	:=affi;
   lbl_nom_erreur.caption    :=  ' ' ;
   edt_prenom.clear;
   edt_prenom.ReadOnly	:=affi;
   lbl_prenom_erreur.caption    :=  ' ' ;

// initialisation adresse
   edt_adresse.clear;
   edt_adresse.ReadOnly	:=affi;
   lbl_adresse_erreur.caption    :=  ' ' ;
   edt_cp.clear;
   edt_cp.ReadOnly	:=affi;
   lbl_cp_erreur.caption    :=  ' ' ;
   edt_ville.clear;
   edt_ville.ReadOnly	:=affi;
   lbl_ville_erreur.caption    :=  ' ' ;

// initialisation contact
   edt_telephone.clear;
   edt_telephone.ReadOnly	:=affi;
   lbl_telephone_erreur.caption    :=  ' ' ;
   edt_mel.clear;
   edt_mel.ReadOnly	:=affi;
   lbl_mel_erreur.caption    :=  ' ' ;
   edt_portable.clear;
   edt_portable.ReadOnly	:=affi;

// initialisation filiere
   edt_filiere.clear;
   edt_filiere.ReadOnly	:=affi;
   lbl_filiere_erreur.caption    :=  ' ' ;

//initialisation boutons
   btn_retour.visible	:=affi;  // visible quand affichage détail
   btn_valider.visible	:=NOT  affi;    // visible quand ajout/modification inscription
   btn_annuler.visible	:=NOT  affi;    // visible quand ajout/modification inscription

// initialisation relevé
   f_releve_list.borderstyle  := bsNone;
   f_releve_list.parent  := pnl_releve_list;
   f_releve_list.align  := alClient;
   f_releve_list.init(affi);
   f_releve_list.show;
   f_releve_list.affi_data(modele.inscrit_notes(idinf));

   show;

   id  := idinf;
   IF  NOT  ( id = '')   // affichage/modification inscription
   THEN  affi_page;

end;


function  Tf_detail_inscrit.affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
begin
   lbl.caption := erreur;
   if  NOT (erreur = '')
   then begin
	edt.setFocus;
	result := false;
   end
   else result := true;
end;

procedure	Tf_detail_inscrit.affi_page;
var
   flux:TLoadDataSet;
begin
   flux   := modele.inscrit_num(id);
   flux.read;
   edt_num.text	                    := flux.Get('id_etu');
   edt_nom.text	                    := flux.Get('nom');
   edt_prenom.text                  := flux.Get('prenom');
   edt_adresse.text	            := flux.Get('adresse');
   edt_cp.text	                    := flux.Get('cp');
   edt_ville.text	            := flux.Get('ville');
   edt_telephone.text	            := flux.Get('telephone');
   edt_portable.text	            := flux.Get('portable');
   edt_mel.text	                    := flux.Get('mel');
   edt_filiere.text	            := flux.Get('code_fil');
   lbl_filiere_court.Caption	    := flux.Get('libcourt_fil');
   lbl_filiere_long.Caption	    := flux.Get('libmilong_fil');
   IF flux.Get('civ')='M' THEN cbx_civ.ItemIndex:=0
   ELSE IF flux.Get('civ')='Mme' THEN cbx_civ.ItemIndex:=1
   ELSE begin cbx_civ.ItemIndex:=-1 ;
   end;
   flux.destroy;
end;

procedure	Tf_detail_inscrit.detail (idinf : string);
begin
   init (idinf, true);    // mode affichage
   pnl_titre.caption	:= 'Détail d''une inscription';
   btn_retour.setFocus;
end;

procedure	Tf_detail_inscrit.edit (idinf : string);
begin
   init (idinf, false);
   pnl_titre.caption	:= 'Modification d''une inscription';
   edt_num.setFocus;
end;

procedure  Tf_detail_inscrit.add;
begin
   init ('',false);   // pas de numéro d'inscription
   pnl_titre.caption   := 'Nouvelle inscription';
   edt_num.setFocus;
end;

procedure Tf_detail_inscrit.delete (idinf : string);
begin
   IF   messagedlg ('Demande de confirmation'
	,'Confirmez-vous la suppression de l''inscription n°' +idinf
	,mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes
   THEN  BEGIN
          // suppression dans la base, complété par la suite
          modele.inscrit_notes_delete(idinf);
          modele.inscrit_delete (idinf);
          f_list_inscrit.line_delete;
   END;
end;

procedure Tf_detail_inscrit.edt_Enter(Sender: TObject);
begin
     oldvaleur := TEdit(Sender).text;
end;

procedure Tf_detail_inscrit.btn_annulerClick(Sender: TObject);
begin
     close;
end;

procedure Tf_detail_inscrit.btn_retourClick(Sender: TObject);
begin
     close;
end;

procedure Tf_detail_inscrit.btn_validerClick(Sender: TObject);
  var
    flux	     : TLoadDataSet;
    saisie, erreur, ch	 : string;
    i 	     : integer;
    valide  : boolean;
begin
    valide := true;

    erreur := '';
    saisie := edt_nom.text;
    if  saisie = ''  then  erreur := 'Le nom doit être rempli.';
    valide := affi_erreur_saisie (erreur, lbl_nom_erreur, edt_nom)  AND  valide;

    erreur := '';
    saisie := edt_prenom.text;
    if  saisie = ''  then  erreur := 'Le prenom doit être rempli.';
    valide := affi_erreur_saisie (erreur, lbl_prenom_erreur, edt_prenom)  AND  valide;

    erreur := '';
    saisie := edt_adresse.text;
    if  saisie = ''  then  erreur := 'L`adresse doit être remplie.';
    valide := affi_erreur_saisie (erreur, lbl_adresse_erreur, edt_adresse)  AND  valide;

    erreur := '';
    saisie := edt_cp.text;
    if  saisie = ''  then  erreur := 'Le CP doit être rempli.';
    valide := affi_erreur_saisie (erreur, lbl_cp_erreur, edt_cp)  AND  valide;

    erreur := '';
    saisie := edt_ville.text;
    if  saisie = ''  then  erreur := 'La ville doit être remplie.';
    valide := affi_erreur_saisie (erreur, lbl_ville_erreur, edt_ville)  AND  valide;
    erreur := '';

    erreur := '';
    saisie := edt_telephone.text;
    if  saisie = ''  then  erreur := 'Le téléphone doit être rempli.';
    valide := affi_erreur_saisie (erreur, lbl_telephone_erreur, edt_telephone)  AND  valide;

    erreur := '';
    saisie := edt_portable.text;
    if  saisie = ''  then  erreur := 'Le portable doit être rempli.';
    valide := affi_erreur_saisie (erreur, lbl_telephone_erreur, edt_portable)  AND  valide;

    erreur := '';
    saisie := edt_mel.text;
    if  saisie = ''  then  erreur := 'Le mel doit être rempli.';
    valide := affi_erreur_saisie (erreur, lbl_mel_erreur, edt_mel)  AND  valide;

    erreur := '';
    saisie := edt_filiere.text;
    if  saisie = ''  then  erreur := 'Le code filière doit être rempli.'
    else  begin

    ch := modele.recherche_filiere(saisie);
    if  ch = ''  then erreur := 'Code filière inexistant.';
    end;
    valide := affi_erreur_saisie (erreur, lbl_filiere_erreur, edt_filiere)  AND  valide;

    if  id = ''
    then begin
	 erreur := '';
	 saisie := edt_num.text;
	 if  saisie = ''   then  erreur := 'Le numéro doit être rempli.'
	 else begin
	      flux := modele.inscrit_liste_etudiant(saisie, '');
	      if  NOT  flux.endOf
	      then  erreur := 'Le numéro existe déjà';
	 end;
	 valide := affi_erreur_saisie (erreur, lbl_num_erreur, edt_num)  AND  valide;
    end;

    if  NOT  valide
    then  messagedlg ('Erreur enregistrement Inscription', 'La saisie est incorrecte.' +#13 +'Corrigez la saisie et validez à nouveau.', mtWarning, [mbOk], 0)
    else  begin
         if  id =''
         then  modele.inscrit_insert (edt_num.Text, cbx_civ.Items[cbx_civ.ItemIndex], edt_nom.Text, edt_prenom.Text, edt_adresse.Text, edt_cp.Text, edt_ville.Text, edt_telephone.Text, edt_portable.Text, edt_mel.Text, edt_filiere.Text)
         else  begin
       	       modele.inscrit_update (id, cbx_civ.Items[cbx_civ.ItemIndex], edt_nom.text, edt_prenom.text, edt_adresse.text, edt_cp.text, edt_ville.text, edt_telephone.text, edt_portable.text, edt_mel.Text)
         end;

	  if id='' then f_list_inscrit.line_add(modele.inscrit_liste_etudiant(edt_num.text,''))
   	  else f_list_inscrit.line_edit(modele.inscrit_liste_etudiant(id,''));
   	  close;
    end;
end;

procedure Tf_detail_inscrit.edt_adresseExit(Sender: TObject);
begin
   edt_adresse.text := TRIM(edt_adresse.text);
end;

procedure Tf_detail_inscrit.edt_cpExit(Sender: TObject);
begin
   edt_cp.text := TRIM(edt_cp.text);
end;

procedure Tf_detail_inscrit.edt_melExit(Sender: TObject);
begin
   edt_mel.text := TRIM(edt_mel.text);
end;

procedure Tf_detail_inscrit.edt_nomExit(Sender: TObject);
begin
   edt_nom.text := TRIM(edt_nom.text);
end;

procedure Tf_detail_inscrit.edt_numExit(Sender: TObject);
begin
    edt_num.text := TRIM(edt_num.text);
end;

procedure Tf_detail_inscrit.edt_portableExit(Sender: TObject);
begin
   edt_portable.text := TRIM(edt_portable.text);
end;

procedure Tf_detail_inscrit.edt_prenomExit(Sender: TObject);
begin
   edt_prenom.text := TRIM(edt_prenom.text);
end;

procedure Tf_detail_inscrit.edt_telephoneExit(Sender: TObject);
begin
   edt_telephone.text := TRIM(edt_telephone.text);
end;

procedure Tf_detail_inscrit.edt_villeExit(Sender: TObject);
begin
   edt_ville.text := TRIM(edt_ville.text);
end;

procedure Tf_detail_inscrit.edt_filiereExit(Sender: TObject);
begin
   edt_filiere.text := TRIM(edt_filiere.text);
end;
end.

